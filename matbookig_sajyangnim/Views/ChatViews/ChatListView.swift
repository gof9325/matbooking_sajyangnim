//
//  ChatListView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/10.
//

import SwiftUI

struct ChatListView: View {
    
    @ObservedObject var chatVM: ChatViewModel
    
    @State var chatList = [ChatListResponse]()
    
    var body: some View {
        NavigationView {
            Group {
                switch chatVM.chatListLoadingState {
                case .beforeLoad:
                    EmptyView()
                case .loading:
                    ProgressView()
                case .didLoaded:
                    if chatList.isEmpty {
                        Text("채팅리스트가 없습니다.")
                    } else {
                        List {
                            ForEach(chatList, id:\.self) { item in
                                NavigationLink(destination: ChatDetailView(chatVM: chatVM, restuarant: item)) {
                                    ChatListItemView(chat: item)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("채팅목록")
        }
        .onAppear {
            chatVM.chatListLoadingState = .loading
            chatVM.getChatList()
        }
        .onReceive(chatVM.$chatList, perform: { self.chatList = $0 ?? [ChatListResponse]() })
    }
}
