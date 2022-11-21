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
    
    @State var pictureList = [Picture]()
    
    var body: some View {
        NavigationView {
            VStack {
                switch restaurantVM.restaurantInfoState {
                case .none:
                    GeometryReader { proxy in
                        TabView(selection: $selection) {
                            ChatListView()
                                .tag(1)
                                .tabItem{
                                    Image(systemName: "message")
                                    Text("채팅목록")
                                }
                            ReservationListView()
                                .tag(0)
                                .tabItem{
                                    Image(systemName: "list.bullet")
                                    Text("예약목록")
                                }
                            MyRestaurantView(pictureList: pictureList, myRestaurant: myRestaurant, restaurantVM: restaurantVM)
                                .tag(2)
                                .tabItem{
                                    Image(systemName: "house")
                                    Text("내 가게")
                                }
                        }
                    }
                case .editing:
                    RestaurantInfoEditView(restaurantVM: restaurantVM, pictureList: pictureList, myRestaurant: myRestaurant)
                }
            }
            .onReceive(restaurantVM.getImageFinished, perform: {
                if !$0.isEmpty {
                    pictureList.removeAll()
                    print("ContentView onReceive getImage: \($0)")
                    for data  in $0 {
                        pictureList.append(Picture(isNeedUpload: false, image: UIImage(data: data) ?? UIImage()))
                    }
                }
            })
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(restaurantVM: RestaurantViewModel(), myRestaurant: Restaurant(id: ""))
//    }
//}
