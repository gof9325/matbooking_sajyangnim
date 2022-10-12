//
//  SettingRestaurant.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/07.
//

import SwiftUI

struct RestaurantInfoEditView: View {
    @EnvironmentObject var ownerVM: OwnerViewModel
    
    @State var restaurantName = ""
    @State var restaurantInfo = ""
    
    var pictureList = [
        "person", "shield"
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section("가게 사진", content: {
                        ScrollView(.horizontal) {
                            LazyHStack() {
                                ForEach(pictureList, id:\.self){ picture in
                                    Image(systemName: picture)
                                        .resizable()
                                        .scaledToFit()
                                }
                            }
                        }
                        .frame(height: 300)
                    })
                    Section(header: Text("가게 이름"), content: {
                        TextField("가게 이름", text: $restaurantName)
                    })
                    Section(header: Text("가게 설명"), content: {
                        TextEditor(text: $restaurantInfo)
                            .frame(height: 200, alignment: .leading)
                    })
                }
                HStack {
                    Spacer()
                    Button("완료") {
                        // addRestaurant
                    }
                    .frame(width: 50)
                    .padding(10)
                    .background(.cyan)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    Spacer()
                    Button("취소") {
                        // 가장 처음의 로그인 화면으로 전환
//                        ownerVM.auth0Owner = nil
                    }
                    .frame(width: 50)
                    .padding(10)
                    .background(.cyan)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    Spacer()
                }
            }
            .navigationTitle("가게 정보 설정")
        }
    }
}

struct SettingRestaurant_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantInfoEditView()
    }
}
