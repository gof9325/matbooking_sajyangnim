//
//  ChatListView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/10.
//

import SwiftUI

struct Chat: Hashable {
    let restaurantName: String
    let content: String
}

struct ChatListView: View {
    
    var chatList = [
        Chat(restaurantName: "고객 ID1", content: "채팅 내용1"),
        Chat(restaurantName: "고객 ID2", content: "채팅 내용2")
    ]
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(chatList, id:\.self) { item in
                        NavigationLink(destination: ChatDetailView()) {
                            ChatListItemView(chat: item)
                        }
                    }
                }
                .navigationTitle("채팅목록")
            }
        }
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
