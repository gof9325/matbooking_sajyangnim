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
                Spacer()
                Spacer()
                Form {
                    Section("닉네임") {
                        TextField("닉네임", text: $name)
                    }
                    Section("전화번호") {
                        TextField("000-0000-0000", text: $mobile)
                            .keyboardType(.phonePad)
//                            .onChange(of: mobile, perform: { mobile in
//                                if mobile.validatePhone(number: mobile) {
//                                    self.mobile = mobile.withHypen
//                                    validateMobileNumber = true
//                                } else {
//                                    validateMobileNumber = false
//                                }
//                            })
//                            .foregroundColor(validateMobileNumber ? Color.black : Color.red)
                    }
                }
                .padding()
                .cornerRadius(80)
                HStack {
                    Spacer()
                    Button("완료") {
                        if let auth0User = userVM.auth0User {
//                            userVM.join(name: name, mobile: mobile, auth0User)
                        }
                    }
                    .matbookingButtonStyle(width: 100)
                    Spacer()
                    Button("취소") {
                        isPresented = false
                    }
                    .matbookingButtonStyle(width: 100)
                    Spacer()
                }
                .onReceive(userVM.$user, perform: {
                    if $0 != nil {
                        isPresented = false
                    }
                })
            }
        }
        
    }
}

struct JoinView_Previews: PreviewProvider {
    static var previews: some View {
        JoinView(isPresented: .constant(true))
    }
}
