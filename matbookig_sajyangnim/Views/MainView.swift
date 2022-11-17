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
    
    @State var isLoaded = false
    
    @State var currentView = ""
    
    var body: some View {
        VStack {
            if auth0Owner != nil {
                if !isLoaded {
                    ProgressView()
                } else {
                    if ownerAndRestaurant?.1 != nil {
                        ContentView(restaurantVM: restaurantVM, myRestaurant: ownerAndRestaurant!.1!)
                    } else {
                        if ownerAndRestaurant?.0 == nil {
                            JoinView()
                        } else {
                            if ownerAndRestaurant?.1 == nil {
                                RestaurantCreationView(restaurantVM: restaurantVM, myRestaurant: Restaurant(id: ""))
                            } else {
                                ProgressView()
                            }
                        }
                    }
                }
            } else {
                LoginView(mainVM: mainVM)
            }
        }
        .onReceive(ownerVM.$auth0Owner, perform: {
            mainVM.getOwnerAndRestaurantExists()
            self.auth0Owner = $0
        })
        .onReceive(ownerVM.$owner, perform: {
            if $0 != nil {
                self.ownerAndRestaurant?.0 = $0
            }
        })
        .onReceive(mainVM.dataLoaded, perform: {
            self.ownerAndRestaurant = $0
            isLoaded = true
        })
        .onReceive(restaurantVM.$myRestaurant, perform: {
            if $0 != nil { self.ownerAndRestaurant?.1 = $0! }
        })
        .onAppear() {
            mainVM.ownerVM = ownerVM
            mainVM.restaurantVM = restaurantVM
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(mainVM: MainViewModel())
//    }
//}
