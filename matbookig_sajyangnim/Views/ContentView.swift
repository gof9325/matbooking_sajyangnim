//
//  ContentView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/07.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var ownerVM: OwnerViewModel
    @State var owner: Owner?
    
    var body: some View {
        VStack {
            if self.owner != nil {
                Text("asdfsdf")
                TabView{
                    ReservationListView()
                        .tabItem{
                            Image(systemName: "book.closed")
                        }
                    ChatListView()
                        .tabItem{
                            Image(systemName: "message")
                        }
                }
            } else {
                LoginView()
            }
        }.onReceive(ownerVM.$owner, perform: {self.owner = $0})
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
