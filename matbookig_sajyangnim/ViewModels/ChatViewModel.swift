//
//  ChatViewModel.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/11/23.
//

import Foundation
import Alamofire
import Combine

class ChatViewModel: ObservableObject {
    private var subscription = Set<AnyCancellable>()
    
    enum chatListLoadingState {
        case beforeLoad, loading, didLoaded
    }
    
    let socket = CodableWebSocket(url:URL(string:"ws://165.22.105.229:3001")!)
    var cancelable:AnyCancellable?
    
    @Published var chatList: [ChatListResponse]?
    @Published var chatDetailList: [ChatDetail]?
    @Published var chatListLoadingState: chatListLoadingState = .beforeLoad
    
    init() {
        cancelable = socket
            .codable()
            .receive(on: DispatchQueue.main)
            .filterOutErrors()
            .sink(receiveCompletion: { completion in
                print("ChatViewModel - socket receive : \(completion)")
            }, receiveValue: { chatMessage in
                print("Receved:\(chatMessage)")
                self.chatDetailList?.append(ChatDetail(id: UUID().uuidString, createdAt: Date(), message: chatMessage.data, type: .CustomerToStore))
            })
    }
    
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
    
    func getChatDetailList(id: String) {
        print("ChatViewModel - getChatDetailList() called")
        ChatApiService.getChatDetailList(id: id)
            .sink(receiveCompletion: { completion in
                print("ChatViewModel getChatDetailList completion: \(completion)")
            }, receiveValue: { chatDetailList in
                self.chatDetailList = chatDetailList.map{ item in
                    ChatDetail(id: item.id, createdAt: item.createdAt.formattingToDate() ?? Date(), message: item.message, type: item.type)
                }
            }).store(in: &subscription)
    }
    
}

extension Publisher {
    func filterOutErrors() -> Publishers.CompactMap<Publishers.ReplaceError<Publishers.Map<Self, Self.Output?>>, Self.Output>
    {
        map{ Optional($0)}
            .replaceError(with:nil)
            .compactMap{$0}
    }
}
