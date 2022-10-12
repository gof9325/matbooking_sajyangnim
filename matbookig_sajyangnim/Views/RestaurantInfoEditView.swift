//
//  SettingRestaurant.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/07.
//

import SwiftUI

struct RestaurantInfoEditView: View {
    @EnvironmentObject var ownerVM: OwnerViewModel
    
    //    @State var restaurantName = ""
    //    @State var restaurantAddress = ""
    //    @State var restaurantDescription = ""
    
    @State var paxMin = 1
    @State var paxMax = 1
    
    @State var openAllweek = true
    
    @State var days = ["월", "화", "수", "목", "금", "토", "일"]
    
    @State var selectedDays: [String] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
//                PictureContentView()
                
                VStack(alignment: .leading) {
                    
//                    InPutField()
                    
                    Text("예약 정보 설정")
                    VStack {
                        Stepper(value: $paxMin, in: 0...20) {
                            Image(systemName: "person")
                            Text("최소인원")
                            Text("\(paxMin)")
                        }
                        
                        Stepper(value: $paxMax, in: 0...20) {
                            Image(systemName: "person")
                            Text("최소인원")
                            Text("\(paxMax)")
                        }
                    }
                    
                    Text("영업날짜 & 시간")
                    
                    Toggle(isOn: $openAllweek) {
                        Text("휴무일")
                    }
                    
                    if openAllweek {
                        HStack {
                            Spacer()
                            HStack{
                                ForEach(days, id:\.self) { day in
                                    Button(day) {
                                        if selectedDays.contains(day) {
                                            selectedDays.remove(at: selectedDays.firstIndex(where: { $0 == day }) ?? 0)
                                        } else {
                                            selectedDays.append(day)
                                        }
                                    }
                                    .padding(10)
                                    .background(selectedDays.contains(day) ? Color.matSkin : .clear)
                                    .foregroundColor(selectedDays.contains(day) ? .white : .black)
                                    .clipShape(Circle())
                                    
                                    // 영업시간 설정(데일리)
                                    
                                    
                                }
                            }
                            .padding()
                            Spacer()
                        }
                        
                    }
                    
                    
                }
                .padding()
                
                buttonGroup
            }
            .navigationTitle("가게 정보 설정")
        }
    }
    
    var buttonGroup: some View {
        VStack {
            HStack {
                Spacer()
                Button("완료") {
                    // addRestaurant
                }
                .matbookingButtonStyle(width: 100, color: .cyan)
                Spacer()
                Button("취소") {
                    ownerVM.joinCancel()
                }
                .matbookingButtonStyle(width: 100, color: .cyan)
                Spacer()
            }
        }
    }
    
}

struct PictureContentView: View {
    
    var pictureList = [
        "person", "shield"
    ]
    
    var body: some View {
        VStack {
            Text("가게 이미지")
                .font(.largeTitle)
                .padding(.top)
            ImageSlider(images: pictureList)
                .background(.green)
                .cornerRadius(10)
                .padding(5)
                .frame(minHeight: 300)
        }
    }
}

struct InPutField: View {
    
    @State var restaurantName = ""
    @State var restaurantAddress = ""
    @State var restaurantDescription = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("가게 이름")
                .padding(.leading, 8)
                .padding(.top)
                .foregroundColor(.gray)
            TextField("가게 이름", text: $restaurantName)
                .underlineTextField(color: .blue)
            
            Text("가게 주소")
                .padding(.leading, 8)
                .padding(.top)
                .foregroundColor(.gray)
            TextField("00시 00동 000-000", text: $restaurantAddress)
                .underlineTextField(color: .blue)
            
            Text("가게 번호")
                .padding(.leading, 8)
                .padding(.top)
                .foregroundColor(.gray)
            TextField("000-000-000", text: $restaurantAddress)
                .underlineTextField(color: .blue)
            
            Text("가게 설명")
                .padding(.leading, 8)
                .padding(.top)
                .foregroundColor(.gray)
            TextEditor(text: $restaurantDescription)
                .frame(height: 200, alignment: .leading)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue)
                )
                .padding()
        }
        
    }
}

struct SettingRestaurant_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantInfoEditView()
    }
}
