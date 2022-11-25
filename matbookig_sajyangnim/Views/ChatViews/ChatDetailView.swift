//
//  ChatView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/10.
//

import SwiftUI

struct ChatDetailView: View {
    @State var inputText: String = ""
    
    @ObservedObject var chatVM: ChatViewModel
    
    let customer: ChatListResponse
    
    @State var chatDetailList = [ChatDetail]()
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                        LazyVStack {
                            ForEach(chatDetailList, id:\.self) { chat in
                                Group{
                                    if chat.type == .CustomerToStore {
                                        HStack {
                                            Image(systemName: "person")
                                                .padding()
                                                .background(.gray.opacity(0.5))
                                                .clipShape(Circle())
                                            Text("\(chat.message)")
                                                .padding()
                                                .background(Color.matNature)
                                                .cornerRadius(20)
                                                .foregroundColor(Color.matBlack)
                                            Spacer()
                                        }
                                    } else {
                                        HStack {
                                            Spacer()
                                            Text("\(chat.message)")
                                                .padding()
                                                .background(Color.matGreen)
                                                .cornerRadius(20)
                                                .foregroundColor(.white)
                                            Image(systemName: "person")
                                                .padding()
                                                .background(.gray.opacity(0.5))
                                                .clipShape(Circle())
                                        }
                                    }

                            }
                        }                    
                }
                Spacer()
            }
            .navigationBarTitle("\(customer.customer.name)님 과의 대화")
            .navigationBarTitleDisplayMode(.inline)
            HStack {
                TextField("", text: $inputText)
                    .padding()
                    .background(.gray.opacity(0.3))
                    .cornerRadius(15)
                Button("send") {
                    _ = chatVM.socket.receive(.outgoingMessage(ChatSocketSend(data: ChatSocketSend.ChatData(to: customer.customer.id, message: inputText))))
                    chatDetailList.append(ChatDetail(id: UUID().uuidString, createdAt: Date(), message: inputText, type: .StoreToCustomer))
                    inputText = ""
                }
                .matbookingButtonStyle(width: 80,color: Color.matNature)
            }
        }
        .padding()
        .onAppear {
            _ = chatVM.socket.receive(.outgoingMessage(ChatAuth()))
            chatVM.getChatDetailList(id: customer.customer.id)
        }
        .onReceive(chatVM.$chatDetailList, perform: {
            self.chatDetailList = $0 ?? [ChatDetail]()
            chatDetailList.sort{ return $0.createdAt < $1.createdAt }
        })
    }
}
