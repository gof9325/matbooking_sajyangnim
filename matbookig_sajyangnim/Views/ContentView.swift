//
//  ContentView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/07.
//

import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var ownerVM: OwnerViewModel
    
    @StateObject var restaurantVM = RestaurantViewModel()
    
    @StateObject var contentVM: ContentViewModel
    
    @State var auth0Owner: Auth0Owner?
    
    @State var ownerAndRestaurant: (Owner?, Restaurant?)?
    
    @State var haveToJoin = false
    
    @State var selection = 0
    
    var body: some View {
        ScrollView {
            VStack {
                if auth0Owner != nil {
                    if ownerAndRestaurant?.0 != nil && ownerAndRestaurant?.1 != nil {
                        Text("아이디, 레스토랑 둘 다 있음")
                    } else if ownerAndRestaurant?.0 != nil && ownerAndRestaurant?.1 == nil {
//                        Text("아이디 있음, 레스토랑 없음")
                        RestaurantInfoEditView(myRestaurant: Restaurant(name: "", address: "", mobile: "", description: "", openTimeDescription: ""))
                    } else {
//                        Text("둘다 없음")
                        JoinView()
                    }
                } else {
                    LoginView(contentVM: contentVM)
                }
            }
            .onReceive(ownerVM.$auth0Owner, perform: {
                contentVM.getOwnerAndRestaurantExists()
                self.auth0Owner = $0
            })
            .onReceive(contentVM.dataLoaded, perform: {
                self.ownerAndRestaurant = $0
            })
        }.onAppear() {
            contentVM.ownerVM = ownerVM
            contentVM.restaurantVM = restaurantVM
        }
        EmptyView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(contentVM: ContentViewModel())
    }
}
