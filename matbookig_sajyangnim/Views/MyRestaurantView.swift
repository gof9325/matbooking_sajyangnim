//
//  MyRestaurantView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/31.
//

import SwiftUI

struct MyRestaurantView: View {
    
    @State var myRestaurant: Restaurant
    
    var body: some View {
        VStack {
            Text(myRestaurant.storeInfo.name)
        }
    }
}

struct MyRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        MyRestaurantView(myRestaurant: Restaurant(id: ""))
    }
}
