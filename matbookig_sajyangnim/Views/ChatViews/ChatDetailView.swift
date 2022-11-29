//
//  ChatView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/10.
//

import SwiftUI

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct ChatDetailView: View {
    
    @StateObject private var viewModel: ViewModel = ViewModel()
    
    @State var inputText: String = ""
    
    @ObservedObject var chatVM: ChatViewModel
    
    let customer: ChatListResponse
    
    @State var chatDetailList = [ChatDetail]()
    @State var sendNewMessage = false
    @State var messageReceived = false
    @State var isFirstSetting = true
    
    var lastChat: ChatDetail? {
        chatDetailList.last
    }
    
    @State var currentOffSet = CGFloat()
    
    private var scrollObservableView: some View {
        GeometryReader { proxy in
            let offsetY = proxy.frame(in: .global).origin.y
            Color.clear
                .preference(
                    key: ScrollOffsetKey.self,
                    value: offsetY
                )
                .onAppear { // 나타날때 뷰의 최초위치를 저장하는 로직
                    viewModel.setOriginOffset(offsetY)
                }
        }
        .frame(height: 0)
    }
    
    final class ViewModel: ObservableObject {
        var offset: CGFloat = 0
        var originOffset: CGFloat = 0
        var isCheckedOriginOffset: Bool = false
        
        func setOriginOffset(_ offset: CGFloat) {
            guard !isCheckedOriginOffset else { return }
            self.originOffset = offset
            isCheckedOriginOffset = true
        }
        
        func setOffset(_ offset: CGFloat) {
            self.offset = offset
        }
    }

    var body: some View {
        GeometryReader { geometryReaderProxy in
            VStack{
                ScrollViewReader { scrollViewReaderProxy in
                    ScrollView(showsIndicators: false) {
                        ZStack {
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
                                    .id(chat)
                                }
                            }
                            scrollObservableView
                        }
                        .onChange(of: chatDetailList, perform: { _ in
                            if isFirstSetting {
                                scrollViewReaderProxy.scrollTo(lastChat)
                                isFirstSetting = false
                            }
                            if sendNewMessage {
                                withAnimation {
                                    scrollViewReaderProxy.scrollTo(lastChat)
                                    sendNewMessage = false
                                }
                            } else {
                                if !(viewModel.offset <= 800) { // 메세지 받았는데 가장 하단이 아니면 메세지 받음 활성화
                                    messageReceived = true
                                }
                            }
                        })
                    }
                    
                    if messageReceived {
                        GeometryReader {  proxy in
                            HStack {
                                HStack {
                                    Image(systemName: "person")
                                        .padding()
                                        .background(.gray.opacity(0.5))
                                        .clipShape(Circle())
                                    // 텍스트 길때 처리 -> 걍 가장 겉의 fram에 맡기면 되는듯
                                    Text("\(chatDetailList[chatDetailList.count-1].message)")
                                }
                                Spacer()
                                Image(systemName: "arrowtriangle.down.fill")
                            }
                        }
                        .padding()
                        .frame(minWidth: geometryReaderProxy.size.width, maxHeight: geometryReaderProxy.size.height / 9)
                        .onTapGesture {
                            scrollViewReaderProxy.scrollTo(lastChat)
                            
                        }
                        .foregroundColor(Color.matWhiteGreen)
                        .background(Color.matNature)
                        .cornerRadius(10)
                    }
                }
                .onPreferenceChange(ScrollOffsetKey.self) {  // 추가부분
                    viewModel.setOffset($0)
                    if viewModel.offset <= 800 {
                        messageReceived = false
                    }
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
                        sendNewMessage = true
                    }
                    .matbookingButtonStyle(width: 80,color: Color.matNature)
                }
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
