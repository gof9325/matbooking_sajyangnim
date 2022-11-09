//
//  ContentView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/25.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 0
    
    @StateObject var restaurantVM: RestaurantViewModel
    @State var myRestaurant: Restaurant
    
    var title: String {
        switch selection {
        case 0 :
            return "예약목록"
        case 1:
            return "채팅목록"
        case 2:
            return "내 가게"
        default:
            return ""
        }
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                TabView(selection: $selection) {
                    ChatListView()
                        .navigationTitle(title)
                        .tag(1)
                        .tabItem{
                            Image(systemName: "message")
                            Text("채팅목록")
                        }
                    ReservationListView()
                        .navigationTitle(title)
                        .tag(0)
                        .tabItem{
                            Image(systemName: "list.bullet")
                            Text("예약목록")
                        }
                    MyRestaurantView(myRestaurant: myRestaurant, restaurantVM: restaurantVM)
                        .navigationTitle(title)
                        .tag(2)
                        .tabItem{
                            Image(systemName: "house")
                            Text("내 가게")
                        }
                }
                .onAppear{
                    if myRestaurant.storeInfo.pictures != nil {
                        
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(restaurantVM: RestaurantViewModel(), myRestaurant: Restaurant(id: ""))
    }
}
