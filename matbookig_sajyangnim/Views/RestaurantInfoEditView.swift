//
//  SettingRestaurant.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/07.
//

import SwiftUI

struct RestaurantInfoEditView: View {
    @EnvironmentObject var ownerVM: OwnerViewModel
    
    @ObservedObject var restaurantVM: RestaurantViewModel
    
    @State var myRestaurant: Restaurant
    
    @State var isSatisfiedRequiredValues = true
    
    var body: some View {
        GeometryReader { proxy in
            InPutFieldsView(proxy: proxy, restaurantVM: restaurantVM, myRestaurant: $myRestaurant, isEdit: true, isSatisfiedRequiredValues: $isSatisfiedRequiredValues)
                .navigationTitle("가게 정보 설정")
                .padding()
        }
    }
}

struct PictureContentView: View {
    
    @State var pictureList = [UIImage]()
    
    @State var isPresented = false
    
    var body: some View {
        VStack {
            Text("가게 이미지")
                .font(.largeTitle)
                .padding(.top)
            
            VStack {
                if pictureList.isEmpty {
                    Text("이미지가 없습니다.")
                } else {
                    ImageSlider(images: $pictureList)
                }
            }
            .background(.gray)
            .cornerRadius(10)
            .padding(5)
            .frame(minHeight: 300)
            .fullScreenCover(isPresented: $isPresented) {
                PhotoPicker(pickerResult: $pictureList, isPresented: $isPresented)
            }
        }
        .onTapGesture {
            isPresented = true
        }
    }
}

struct InPutFieldsView: View {
    @EnvironmentObject var ownerVM: OwnerViewModel
    
    @Environment(\.dismiss) var dismiss
    
    let proxy: GeometryProxy
    
    @StateObject var restaurantVM: RestaurantViewModel
    
    @StateObject var kakaoPostVM = KakaoPostViewModel()
    
    @Binding var myRestaurant: Restaurant
    
    @State var addressSearch = false
    
    @State private var isCancelled = false
    @State private var isFirstValidationPassed = false
    @State var isEdit: Bool
    
    let cuisine = ["한식", "일식", "이탈리아음식"]
    
    @Binding var isSatisfiedRequiredValues: Bool
    
    var body: some View {
        ScrollView {
            PictureContentView()
            VStack(alignment: .leading) {
                InputFieldContentView(title: "가게 이름", placeHolder: "가게 이름 (50자 이내)", textLimit: 50, inputContent: $myRestaurant.storeInfo.name)
                ZStack(alignment: .bottomTrailing) {
                    InputFieldContentView(title: "가게 주소", placeHolder: "00시 00동 000-000", textLimit: 50, inputContent: $myRestaurant.storeInfo.address)
                    Button(action: {
                        addressSearch = true
                    }, label: {
                        Image(systemName: "magnifyingglass")
                    })
                    .padding(.bottom, proxy.size.height / 20)
                    .padding(.trailing, proxy.size.height / 35)
                    .foregroundColor(Color.matHavyGreen)
                }
                .onReceive(kakaoPostVM.$chosenAddress, perform: {
                    if let newAddress = $0?.roadAddress {
                        myRestaurant.storeInfo.address = newAddress
                        myRestaurant.storeInfo.city = String(newAddress.split(separator: " ")[0])
                    }
                    self.addressSearch = false
                })
                InputFieldContentView(title: "가게 번호", placeHolder: "01012341234", textLimit: 11, inputContent: $myRestaurant.storeInfo.phone)
                    .keyboardType(.numberPad)
                    .onChange(of: myRestaurant.storeInfo.phone, perform: { newMobile in
                        if !newMobile.allSatisfy({ $0.isNumber }) {
                            myRestaurant.storeInfo.phone = ""
                        }
                    })
                VStack {
                    HStack {
                        Text("*")
                            .foregroundColor(.red)
                        Text("음식 종류")
                    }
                    .padding(.top)
                    Picker("", selection: $myRestaurant.storeInfo.cuisine) {
                        ForEach(cuisine, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                }
                DescriptionContentView(title: "가게 설명", description: $myRestaurant.storeInfo.description, placeHolder: "가게에 대한 설명을 200자 이내로 서술하세요", requiredValeu: true)
                DescriptionContentView(title: "영업 설명", description: $myRestaurant.storeInfo.openingHours, placeHolder: "영업과 관련된 설명을 200자 이내로 서술하세요", requiredValeu: false)
            }
            .fullScreenCover(isPresented: $addressSearch) {
                KakaoPostView(viewModel: kakaoPostVM, addressSearch: $addressSearch)
                    .padding()
            }
            .onChange(of: myRestaurant, perform: { newMyRestaurant in
                if !newMyRestaurant.storeInfo.name.isEmpty && !newMyRestaurant.storeInfo.address.isEmpty && !newMyRestaurant.storeInfo.phone.isEmpty && !newMyRestaurant.storeInfo.description.isEmpty {
                    isSatisfiedRequiredValues = true
                } else {
                    isSatisfiedRequiredValues = false
                }
            })
            buttonGroup
        }
    }
    
    var buttonGroup: some View {
        HStack {
            if isSatisfiedRequiredValues {
                Spacer()
                NavigationLink("다음", destination: ReservationEditView(restaurantVM: restaurantVM, myRestaurant: $myRestaurant, isEdit: isEdit))
                    .padding()
                    .frame(width: 100)
                    .background(Color.matNature)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
            Spacer()
            if !isEdit {
                Button("취소") {
                    isCancelled = true
                }
                .matbookingButtonStyle(width: 100, color: Color.matNature)
                .alert("가게 정보 설정을 취소하시겠습니까?", isPresented: $isCancelled) {
                    Button("네", role: .cancel){
                        ownerVM.joinCancel()
                        self.dismiss()
                    }
                    Button("아니오") {
                        isCancelled = false
                    }
                }
                Spacer()
            }
        }
    }
}

struct InputFieldContentView: View {
    let title: String
    let placeHolder: String
    let textLimit: Int
    @Binding var inputContent: String
    
    @State var alertMessege = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("*")
                    .foregroundColor(.red)
                Text(title)
            }
            .padding(.top)
            TextField(placeHolder, text: $inputContent)
                .underlineTextField(color: Color.matHavyGreen)
                .onChange(of: inputContent, perform: { text in
                    if text.count > textLimit {
                        alertMessege = "\(textLimit)자 이하로 작성해주세요."
                    } else {
                        alertMessege = ""
                    }
                })
            Text(alertMessege)
                .foregroundColor(.red)
                .animation(.linear, value: alertMessege)
        }
    }
}

struct DescriptionContentView: View {
    
    let title: String
    @Binding var description: String
    let placeHolder: String
    let requiredValeu: Bool
    
    @State var textColor = Color.gray
    
    var body: some View {
        VStack(alignment: .trailing) {
            VStack(alignment: .center) {
                HStack {
                    if requiredValeu {
                        Text("*")
                            .foregroundColor(.red)
                    }
                    Text(title)
                }.padding(.top)
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $description)
                        .padding()
                        .frame(height: 200, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.matHavyGreen)
                        )
                    if description.isEmpty  {
                        Text(placeHolder)
                            .foregroundColor(Color.gray.opacity(0.5))
                            .padding(.horizontal, 25)
                            .padding(.vertical, 22)
                    }
                }
            }
            .onChange(of: description, perform: { text in
                if text.count >= 200 {
                    textColor = Color.red
                } else {
                    textColor = Color.gray
                }
            })
            Text("\(description.count) / 200")
                .foregroundColor(textColor)
                .padding()
                .animation(.default, value: textColor)
        }
    }
}

//struct SettingRestaurant_Previews: PreviewProvider {
//    static var previews: some View {
//        RestaurantInfoEditView(restaurantVM: RestaurantViewModel() ,myRestaurant: Restaurant(name: "", address: "", mobile: "", description: "", openTimeDescription: ""))
//            .previewInterfaceOrientation(.portraitUpsideDown)
//    }
//}
