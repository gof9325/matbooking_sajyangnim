//
//  SettingRestaurant.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/07.
//

import SwiftUI

struct RestaurantInfoEditView: View {
    @EnvironmentObject var ownerVM: OwnerViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var myRestaurant: Restaurant
    
    @State private var isCancelled = false
    @State private var isFirstValidationPassed = false
    
    var body: some View {
        GeometryReader { proxy in
            NavigationView {
                ScrollView {
                    PictureContentView()
                    VStack(alignment: .leading) {
                        InPutFieldsView(proxy: proxy, myRestaurant: $myRestaurant)
                    }
                    .padding()
                    buttonGroup
                }
                .navigationTitle("가게 정보 설정")
            }
        }
    }
    
    var buttonGroup: some View {
        VStack {
            HStack {
                Spacer()
                NavigationLink(destination: ReservationEditView(), isActive: $isFirstValidationPassed) {
                    Button("다음") {
                        isFirstValidationPassed = ownerVM.restaurantEditerValidation(myRestaurant: myRestaurant)
                    }
                }
                Spacer()
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

struct PictureContentView: View {
    
    var pictureList = [
        "person", "shield"
    ]
    
    var body: some View {
        VStack {
            Text("가게 이미지")
                .font(.largeTitle)
                .padding(.top)
            ImageSlider(images: pictureList)
                .background(.green)
                .cornerRadius(10)
                .padding(5)
                .frame(minHeight: 300)
        }
    }
}

struct InPutFieldsView: View {
    
    let proxy: GeometryProxy
    
    @StateObject var kakaoPostVM = KakaoPostViewModel()
    
    @Binding var myRestaurant: Restaurant
  
    @State var addressSearch = false
    
    let cuisine = ["한식", "일식", "이탈리아음식"]
    
    @State var selectedCuisine: String = "한식"
    
    var body: some View {
        VStack {
            InputFieldContentView(title: "가게 이름", placeHolder: "가게 이름 (50자 이내)", textLimit: 50, inputContent: $myRestaurant.name)
            ZStack(alignment: .bottomTrailing) {
                InputFieldContentView(title: "가게 주소", placeHolder: "00시 00동 000-000", textLimit: 50, inputContent: $myRestaurant.address)
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
                myRestaurant.address = $0?.roadAddress ?? ""
                self.addressSearch = false
                
            })
            InputFieldContentView(title: "가게 번호", placeHolder: "000-0000-0000", textLimit: 11, inputContent: $myRestaurant.mobile)
                .keyboardType(.numberPad)
            VStack {
                HStack {
                    Text("*")
                        .foregroundColor(.red)
                    Text("음식 종류")
                }
                .padding(.top)
                Picker("", selection: $selectedCuisine) {
                    ForEach(cuisine, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
            }
            DescriptionContentView(title: "가게 설명", placeHolder: "가게에 대한 설명을 200자 이내로 서술하세요")
            DescriptionContentView(title: "영업 설명", placeHolder: "영업과 관련된 설명을 200자 이내로 서술하세요")
        }
        .sheet(isPresented: $addressSearch) {
            KakaoPostView(viewModel: kakaoPostVM)
                .padding()
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
    @State var description: String = ""
    let placeHolder: String
    
    @State var textColor = Color.black
    
    var body: some View {
        VStack(alignment: .trailing) {
            VStack(alignment: .center) {
                HStack {
                    if title == "가게 설명" {
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

struct SettingRestaurant_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantInfoEditView(myRestaurant: Restaurant(name: "", address: "", mobile: "", description: "", openTimeDescription: ""))
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
