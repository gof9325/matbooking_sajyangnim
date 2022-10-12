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
    @State var myRestaurant: Restaurant?
    
    @State var selection = 0
    
    var body: some View {
        VStack {
            if self.owner != nil && self.myRestaurant != nil {
                Text("asdfsdf")
                TabView(selection: $selection){
                    ReservationListView()
                        .tabItem{
                            Image(systemName: "book.closed")
                        }
                        .tag(0)
                    ChatListView()
                        .tabItem{
                            Image(systemName: "message")
                        }
                        .tag(1)
                    EmptyView()
                        .tabItem{
                            Image(systemName: "fork.knife")
                        }
                        .tag(2)
                }
            } else if self.owner != nil {
                RestaurantInfoEditView()
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
