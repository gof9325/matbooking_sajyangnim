//
//  ChatListItemView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/11/04.
//

import SwiftUI

struct ChatListItemView: View {
    let chat: ChatListResponse?
    
    var body: some View {
        HStack {
            Image(systemName: "person")
                .resizable()
                .clipShape(Circle())
                .scaledToFit()
                .padding()
                .frame(maxHeight: 100, alignment: .leading)
            VStack(alignment: .leading) {
                Text(chat?.customer.name ?? "고객이름")
                    .font(.title2)
                    .padding(5)
                Text(chat?.message ?? "채팅내용")
                    .padding(5)
            }
            .frame(maxHeight: 100)
            Spacer()
        }
    }
}

//struct ChatListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatListItemView(chat: Chat(restaurantName: "가게 이름1", content: "채팅내용 어쩌고 저쩌고 이러쿵 저러쿵 냠냠 쩝쩝 블라블라 ememememem 더 길면 어떻게 되는거지 생략되는건가 음냠냠냠냠 쩝쩝쩝쩝쩝"))
//    }
//}
//
