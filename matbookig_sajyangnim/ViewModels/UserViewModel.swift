//
//  UserViewModel.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/10.
//

import Foundation
import Auth0

class UserViewModel: ObservableObject {
    
    @Published var auth0User: Auth0User?
    
    init(from: String) {
        self.auth0User = Auth0User(from: from)
    }
    
    func login() {
        Auth0
            .webAuth()
            .audience("matbooking-owner.kr")
            .start { result in
                switch result {
                case .success(let credentials):
                    print("Auth0 Login Succeess")
                    print("accessToken : \(credentials.accessToken)")
                    KeyChain.create(key: "userAccessToken", token: credentials.accessToken)
                    if let auth0User = Auth0User(from: credentials.idToken) {
//                        self.getUserInfo(auth0User)
                        self.auth0User = auth0User
                    }
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
    }
    
    func logout() {
        Auth0
            .webAuth()
            .audience("matbooking-owner.kr")
            .clearSession { result in
                switch result {
                case .success:
                    self.auth0User = nil
//                    self.user = nil
                    KeyChain.delete(key: "userAccessToken")
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
    }
}

