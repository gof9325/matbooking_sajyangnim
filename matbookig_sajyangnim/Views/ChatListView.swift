//
//  ChatListView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/10.
//

import SwiftUI

struct ChatListView: View {
    
    @State var chatList = ["ㅁ", "ㄴㅇ"]
    
    var body: some View {
        VStack {
            ScrollView{
                ForEach(chatList, id:\.self) { chat in
                    Text(chat)
                }
            }
        }
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
