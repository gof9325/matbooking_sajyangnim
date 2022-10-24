//
//  LoginView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/10.
//

import SwiftUI

struct LoginView: View {
    @StateObject var contentVM: ContentViewModel
    
    @Environment(\.dismiss) var dismiss

    @State var loginFailAlertPresented = false
    
    var body: some View {
        VStack {
            Text("맛북킹 사장님")
                .font(.title)
                .padding([.top, .bottom])
            Button("시작하기") {
                contentVM.ownerVM?.login()
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .alert("로그인에 실패하였습니다.", isPresented: $loginFailAlertPresented) {
                Button("확인", role: .cancel) {
                    self.dismiss()
                }
            }
        }
        .frame(width: 300, height: 200)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(contentVM: ContentViewModel())
    }
}

