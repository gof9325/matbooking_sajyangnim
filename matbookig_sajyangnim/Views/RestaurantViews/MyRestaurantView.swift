//
//  MyRestaurantView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/31.
//

import SwiftUI

struct MyRestaurantView: View {
    @EnvironmentObject var ownerVM: OwnerViewModel
    
    var pictureList: [Picture]
    
    @State var myRestaurant: Restaurant
    
    @StateObject var restaurantVM: RestaurantViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                    switch restaurantVM.getImageState {
                    case .beforeLoad:
                        Text("로딩전")
                    case .loading:
                        ProgressView()
                    case .didLoaded:
                        ImageSlider(images: pictureList)
                    }
                }
                .background(.gray)
                .cornerRadius(10)
                .padding(5)
                .frame(minHeight: 300)
                .onAppear {
                    if pictureList.isEmpty {
                        restaurantVM.getImages()
                        restaurantVM.getImageState = .loading
                    }
                }
                VStack(alignment: .leading) {
                    Text(myRestaurant.storeInfo.name)
                        .font(.system(size: 50, weight: .heavy))
                        .padding([.top, .bottom], 5)
                    Text(myRestaurant.storeInfo.description)
                        .font(.headline)
                        .padding([.top, .bottom], 5)
                    Text(myRestaurant.storeInfo.subtitle)
                        .font(.body)
                        .padding([.top, .bottom], 5)
                    HStack{
                        Spacer()
                        Image(systemName: "phone")
                        Text(myRestaurant.storeInfo.phone)
                    }
                    .padding([.top, .bottom], 10)
                    HStack {
                        VStack {
                            Text("예약 가능 인원")
                                .padding(.bottom, 5)
                            HStack {
                                Image(systemName: "person.2")
                                Text("\(myRestaurant.reservationRestrictions.paxMin) ~ \(myRestaurant.reservationRestrictions.paxMax) 명")
                            }
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("운영 시간")
                                .padding(.bottom, 5)
                            HStack {
                                Image(systemName: "clock")
                                Text("09:00 ~ 22:00")
                            }
                        }
                    }
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
                .padding()
                HStack {
                    Spacer()
                    Button("가게정보 수정하기"){
                        restaurantVM.restaurantInfoState = .editing
                    }
                    .matbookingButtonStyle(width: 200, color: Color.matNature)
                    Spacer()
                    Button("로그아웃"){
                        ownerVM.logout()
                    }
                    .matbookingButtonStyle(width: 100, color: Color.matNature)
                    Spacer()
                }
            }
            .navigationTitle("내 가게")
            .onReceive(restaurantVM.$myRestaurant, perform: {
                myRestaurant = $0!
            })
        }
    }
}

//struct MyRestaurantView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyRestaurantView(myRestaurant: Restaurant(id: ""), restaurantVM: RestaurantViewModel())
//    }
//}
