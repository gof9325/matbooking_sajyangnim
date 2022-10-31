//
//  ContentView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/07.
//

import SwiftUI
import Combine

struct MainView: View {
    @EnvironmentObject var ownerVM: OwnerViewModel
    
    @StateObject var restaurantVM = RestaurantViewModel()
    
    @StateObject var mainVM: MainViewModel
    
    @State var auth0Owner: Auth0Owner?
    
    @State var ownerAndRestaurant: (Owner?, Restaurant?)?
    
    var body: some View {
        VStack {
                if auth0Owner != nil {
                    if ownerAndRestaurant?.0 != nil && ownerAndRestaurant?.1 != nil {
                        ContentView(restaurantVM: restaurantVM, myRestaurant: ownerAndRestaurant!.1!)
                    } else if ownerAndRestaurant?.0 != nil && ownerAndRestaurant?.1 == nil {
                        RestaurantInfoEditView(restaurantVM: restaurantVM, myRestaurant: Restaurant(id: ""))
                    } else {
                        JoinView()
                    }
                } else {
                    LoginView(mainVM: mainVM)
                }
            }
            .onReceive(ownerVM.$auth0Owner, perform: {
                mainVM.getOwnerAndRestaurantExists()
                self.auth0Owner = $0
            })
            .onReceive(mainVM.dataLoaded, perform: {
                self.ownerAndRestaurant = $0
            })
            .onAppear() {
                mainVM.ownerVM = ownerVM
                mainVM.restaurantVM = restaurantVM
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(mainVM: MainViewModel())
    }
}
