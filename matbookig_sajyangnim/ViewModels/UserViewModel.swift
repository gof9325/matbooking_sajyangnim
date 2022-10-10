//
//  UserViewModel.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/10.
//

import Foundation
import Auth0
import Combine
import Alamofire

class UserViewModel: ObservableObject {
    private var subscription = Set<AnyCancellable>()
    
    @Published var auth0User: Auth0User?
    @Published var user: User?
    
    // 로그인 실패 이벤트
    private var loginFail = PassthroughSubject<(), Never>()
    
    // 회원가입 이벤트
    var haveToJoin = PassthroughSubject<(), Never>()
    
    init(from: String) {
        self.auth0User = Auth0User(from: from)
    }
    
    // MARK: Intant functions
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
                        self.getUserInfo(auth0User)
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
                    self.user = nil
                    KeyChain.delete(key: "userAccessToken")
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
    }
    
    private func getUserInfo(_ auth0User: Auth0User) {
        print("UserViewModel - getUserInfo() called")
        UserApiService.getUserInfo()
            .sink(receiveCompletion: { completion in
                print("UserViewModel getUserInfo completion: \(completion)")
                switch completion {
                case .finished:
                    return
                case .failure(let error) :
                    print("UserViewModel getUserInfo error: \(error)")
                    self.loginFail.send()
                }
            }, receiveValue: { userInfo in
                if userInfo.data.exists {
                    self.user = User(id: auth0User.id, name: userInfo.data.name!, mobile: userInfo.data.mobile!)
                } else {
                    self.haveToJoin.send()
                }
            }).store(in: &subscription)
    }
}

