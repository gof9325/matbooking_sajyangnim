//
//  LoginView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/10.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var ownerVM: OwnerViewModel
    @State var isJoinViewPresented = false
    
    var body: some View {
        if isJoinViewPresented {
            JoinView(isPresented: $isJoinViewPresented)
        } else {
            VStack {
                Text("맛북킹 사장님")
                    .font(.title)
                    .padding([.top, .bottom])
                Button("시작하기") {
                    ownerVM.login()
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
            .frame(width: 300, height: 200)
            .onReceive(ownerVM.haveToJoin, perform: {
                    self.isJoinViewPresented = true
            })
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
