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
    
    @State var isCancle = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                PictureContentView()
                VStack(alignment: .leading) {
                    InPutFieldsView()
                }
                .padding()
                buttonGroup
            }
            .navigationTitle("가게 정보 설정")
        }
    }
    
    var buttonGroup: some View {
        VStack {
            HStack {
                Spacer()
                NavigationLink("다음") {
                    ReservationEditView()
                }
                .padding()
                .frame(width: 100)
                .background(Color.matNature)
                .cornerRadius(10)
                .foregroundColor(.white)
                Spacer()
                Button("취소") {
                    isCancle = true
                }
                .matbookingButtonStyle(width: 100, color: Color.matNature)
                .alert("가게 정보 설정을 취소하시겠습니까?", isPresented: $isCancle) {
                    Button("네", role: .cancel){
                        ownerVM.joinCancel()
                        self.dismiss()
                    }
                    Button("아니오") {
                        isCancle = false
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
    
    @State var restaurantName = ""
    @State var restaurantAddress = ""
    @State var restaurantDescription = ""
    @State var openTimeDescription = ""
    
    var body: some View {
        VStack {
            
            InputFieldContentView(title: "가게 이름", placeHolder: "가게 이름", inputContent: $restaurantName)
            ZStack(alignment: .bottomTrailing) {
                InputFieldContentView(title: "가게 주소", placeHolder: "00시 00동 000-000", inputContent: $restaurantName)
                Button(action: {
                    
                }, label: {
                    Image(systemName: "magnifyingglass")
                })
                .padding([.bottom, .trailing], 25)
                .foregroundColor(Color.matHavyGreen)
            }
            
            InputFieldContentView(title: "가게 번호", placeHolder: "000-0000-0000", inputContent: $restaurantName)

            DescriptionContentView(title: "가게 설명", placeHolder: "가게에 대한 설명을 200자 이내로 서술하세요")
            DescriptionContentView(title: "영업 설명", placeHolder: "영업과 관련된 설명을 200자 이내로 서술하세요")
        }
        
    }
}

struct InputFieldContentView: View {
    let title: String
    let placeHolder: String
    @Binding var inputContent: String
    
    var body: some View {
        VStack {
            Text(title)
                .padding(.top)
            TextField(title, text: $inputContent)
                .underlineTextField(color: Color.matHavyGreen)
        }
    }
}

struct DescriptionContentView: View {
    
    let title: String
    @State var description: String = ""
    let placeHolder: String
    
    var body: some View {
        VStack {
            Text(title)
                .padding(.top)
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
    }
}

struct SettingRestaurant_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantInfoEditView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
