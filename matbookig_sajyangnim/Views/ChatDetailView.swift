//
//  ChatView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/10.
//

import SwiftUI

struct ChatDetailView: View {
    @State var inputText: String = ""
    
    var body: some View {
        VStack {
            Text("맛집사냥꾼 님과의 대화")
                .padding()
            LazyVStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person")
                        .padding()
                        .background(.gray.opacity(0.5))
                        .clipShape(Circle())
                    Text("어쩌고 저쩌고")
                        .padding()
                        .background(Color.matNature)
                        .cornerRadius(20)
                        .foregroundColor(Color.matWhiteGreen)
                }
            }
            Spacer()
            HStack {
                TextField("", text: $inputText)
                    .padding()
                    .background(.gray.opacity(0.3))
                    .cornerRadius(15)
                Button("send") {
                    
                }
                .matbookingButtonStyle(width: 80,color: Color.matNature)
            }
        }
        .padding()
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatDetailView()
    }
}
