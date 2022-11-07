//
//  RestaurantCreationView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/11/01.
//

import SwiftUI

struct RestaurantCreationView: View {
    @EnvironmentObject var ownerVM: OwnerViewModel

    @ObservedObject var restaurantVM: RestaurantViewModel
    
    @State var myRestaurant: Restaurant
    
    @State var isSatisfiedRequiredValues = false
    
    var taskId = UUID()
    
    var body: some View {
        GeometryReader { proxy in
            NavigationView {
                InPutFieldsView(proxy: proxy, restaurantVM: restaurantVM, myRestaurant: $myRestaurant, isEdit: false, isSatisfiedRequiredValues: $isSatisfiedRequiredValues)
                .navigationTitle("가게 정보 설정")
            }
        }
    }
}

//struct ResrtaurantCreationView_Previews: PreviewProvider {
//    static var previews: some View {
//        RestaurantCreationView()
//    }
//}
