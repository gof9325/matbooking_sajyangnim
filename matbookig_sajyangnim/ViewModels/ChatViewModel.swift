//
//  ChatViewModel.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/11/23.
//

import Foundation
import Alamofire
import Combine
import CodableWebSocket

class ChatViewModel: ObservableObject {
    private var subscription = Set<AnyCancellable>()
    
    enum chatListLoadingState {
        case beforeLoad, loading, didLoaded
    }
    
//    let socket = CodableWebSocket(url:URL(string:"ws://165.22.105.229:3001")!)
//    var cancelable:AnyCancellable?
    
    @Published var chatList: [ChatListResponse]?
//    @Published var chatDetailList: [ChatDetail]?
    @Published var chatListLoadingState: chatListLoadingState = .beforeLoad
    
//    init() {
//        cancelable = socket
//            .codable()
//            .receive(on: DispatchQueue.main)
//            .filterOutErrors()
//            .sink(receiveCompletion: { _ in
//
//            }, receiveValue: { chatMessage in
//                self.chatDetailList?.append(ChatDetail(id: UUID().uuidString, createdAt: Date(), message: chatMessage.data.message, type: .StoreToCustomer))
//            })
//    }
    
    func getChatList() {
        print("ChatViewModel - getChatList() called")
        ChatApiService.getChatList()
            .sink(receiveCompletion: { completion in
                print("ChatViewModel getChatList completion: \(completion)")
                self.chatListLoadingState = .didLoaded
            }, receiveValue: { chatList in
                self.chatList = chatList
            }).store(in: &subscription)
    }
    
}

