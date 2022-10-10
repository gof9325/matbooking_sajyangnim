//
//  JoinView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/10.
//

import SwiftUI

struct JoinView: View {
    @EnvironmentObject var userVM: UserViewModel
    @State var name: String = ""
    @State var mobile: String = ""
    
    @State var validateMobileNumber = true
    
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
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
                        TextField("000-0000-0000", text: $name)
                            .padding()
                            .background(.white)
                            .cornerRadius(20)
                    }
                    .padding()
                    .padding(.bottom, 50)
                }
                .background(.gray.opacity(0.1))
                .padding()
                .cornerRadius(70)
                .scaledToFit()
                HStack {
                    Spacer()
                    Button("완료") {
                        if let auth0User = userVM.auth0User {
                            //                            userVM.join(name: name, mobile: mobile, auth0User)
                        }
                    }
                    .padding()
                    .frame(width: 100)
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    Spacer()
                    Button("취소") {
                        isPresented = false
                    }
                    .padding()
                    .frame(width: 100)
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    Spacer()
                }
            }
            .onReceive(userVM.$user, perform: {
                if $0 != nil {
                    isPresented = false
                }
            })
        }
    }
}

struct JoinView_Previews: PreviewProvider {
    static var previews: some View {
        JoinView(isPresented: .constant(true))
    }
}
