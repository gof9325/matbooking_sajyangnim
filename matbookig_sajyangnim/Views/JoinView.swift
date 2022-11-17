//
//  JoinView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/10.
//

import SwiftUI

struct JoinView: View {
    @EnvironmentObject var ownerVM: OwnerViewModel
    @State var name: String = ""
    @State var mobile: String = ""
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack {
                    Text("맛북킹 사장님 회원가입")
                        .font(.largeTitle)
                        .padding()
                    VStack(alignment: .leading) {
                        VStack {
                            Text("닉네임")
                            TextField("닉네임", text: $name)
                                .padding()
                                .background(.white)
                                .cornerRadius(20)
                        }
                        .padding()
                        .padding(.top, 20)
                        VStack {
                            Text("전화번호")
                            TextField("00000000000", text: $mobile)
                                .padding()
                                .background(.white)
                                .cornerRadius(20)
                        }
                        .padding()
                        .padding(.bottom, 50)
                    }
                    .background(.gray.opacity(0.1))
                    .cornerRadius(30)
                    .scaledToFit()
                    HStack(spacing: 50) {
                        Button("완료") {
                            if let auth0Owner = ownerVM.auth0Owner {
                                ownerVM.join(name: name, mobile: mobile, auth0Owner)
                            }
                        }
                        .matbookingButtonStyle(width: 100, color: Color.matNature)
                        Button("취소") {
                            ownerVM.joinCancel()
                        }
                        .matbookingButtonStyle(width: 100, color: Color.matNature)
                    }
                }
                .offset(y: proxy.size.height / 6)
            }
            .padding()
        }
    }
}

struct JoinView_Previews: PreviewProvider {
    static var previews: some View {
        JoinView()
    }
}
