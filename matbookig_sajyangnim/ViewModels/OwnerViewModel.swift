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

class OwnerViewModel: ObservableObject {
    private var subscription = Set<AnyCancellable>()
    
    @Published var auth0Owner: Auth0Owner?
    @Published var owner: Owner?
    
    // 로그인 실패 이벤트
    private var loginFail = PassthroughSubject<(), Never>()
    
    // 회원가입 이벤트
    var haveToJoin = PassthroughSubject<(), Never>()
    
    init(from: String) {
        self.auth0Owner = Auth0Owner(from: from)
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
                    KeyChain.create(key: "ownerAccessToken", token: credentials.accessToken)
                    if let auth0Owner = Auth0Owner(from: credentials.idToken) {
                        self.getOwnerInfo(auth0Owner)
                        self.auth0Owner = auth0Owner
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
                    self.auth0Owner = nil
                    self.owner = nil
                    KeyChain.delete(key: "ownerAccessToken")
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
    }
    
    private func getOwnerInfo(_ auth0Owner: Auth0Owner) {
        print("OwnerViewModel - getOwnerInfo() called")
        OwnerApiService.getOwnerInfo()
            .sink(receiveCompletion: { completion in
                print("OwnerViewModel getOwnerInfo completion: \(completion)")
                switch completion {
                case .finished:
                    return
                case .failure(let error) :
                    print("OwnerViewModel getOwnerInfo error: \(error)")
                    self.loginFail.send()
                }
            }, receiveValue: { ownerInfo in
                if ownerInfo.data.exists {
                    self.owner = Owner(id: auth0Owner.id, name: ownerInfo.data.name!, mobile: ownerInfo.data.mobile!)
                } else {
                    self.haveToJoin.send()
                }
            }).store(in: &subscription)
    }
    
    func join(name: String, mobile: String, _ auth0Owenr: Auth0Owner) {
        print("OwnerViewModel - join() called")
        OwnerApiService.join(name: name, mobile: mobile)
            .sink(receiveCompletion: { completion in
                print("OwnerViewModel join completion: \(completion)")
            }, receiveValue: { userInfo in
                self.owner = Owner(id: auth0Owenr.id, name: userInfo.data.name, mobile: userInfo.data.mobile)
            }).store(in: &subscription)
    }
}

