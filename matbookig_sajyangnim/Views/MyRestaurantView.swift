//
//  MyRestaurantView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/31.
//

import SwiftUI

struct MyRestaurantView: View {
    
    @State var myRestaurant: Restaurant
    
    @StateObject var restaurantVM: RestaurantViewModel
    
    var body: some View {
//        NavigationView {
            VStack {
                ScrollView {
                    ImageSlider(images: ["house", "person"])
                        .frame(minHeight: 300)
                        .background(.yellow)
                    VStack(alignment: .leading) {
                        Text(myRestaurant.storeInfo.name)
                            .font(.system(size: 50, weight: .heavy))
                            .padding([.top, .bottom], 5)
                        Text(myRestaurant.storeInfo.description)
                            .font(.headline)
                            .padding([.top, .bottom], 5)
                        HStack{
                            Spacer()
                            Image(systemName: "phone")
                            Text(myRestaurant.storeInfo.phone)
                        }
                        .padding([.top, .bottom], 5)
                    }
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
                    .padding()
                    NavigationLink("가게정보 수정하기", destination: RestaurantInfoEditView(restaurantVM: restaurantVM, myRestaurant: myRestaurant))
                    .padding()
                    .frame(width: 160)
                    .background(Color.matNature)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                }
                .onReceive(restaurantVM.$myRestaurant, perform: {
                    myRestaurant = $0!
                })
//                .navigationBarHidden(true)
            }
            
        }
//    }
}

struct MyRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        MyRestaurantView(myRestaurant: Restaurant(id: ""), restaurantVM: RestaurantViewModel())
    }
}
