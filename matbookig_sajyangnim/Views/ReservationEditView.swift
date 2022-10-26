//
//  ReservationEditView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/13.
//

import SwiftUI

struct ReservationEditView: View {
    @EnvironmentObject var ownerVM: OwnerViewModel
    
    @ObservedObject var restaurantVM: RestaurantViewModel
    
    @State var days = ["월", "화", "수", "목", "금", "토", "일"]
    
    @Binding var myRestaurant: Restaurant
    
    @State var isSettingPaxFieldSatisfied = false
    @State var isBusinessTimeFieldSatisfied = false
    
    var body: some View {
        GeometryReader { proxy in
            NavigationView {
                ScrollView {
                    VStack {
                        SettingPax(isPaxMinSatisfiedValue: $isSettingPaxFieldSatisfied)
                            .padding()
                        VStack {
                            Text("영업날짜 & 시간")
                            HStack {
                                VStack{
                                    ForEach(days, id:\.self) { day in
                                        BusinessDayView(day: day, isBusinessFieldSatisfied: $isBusinessTimeFieldSatisfied, proxy: proxy)
                                    }
                                }
                                .padding([.top, .bottom])
                            }
                        }
                        SettingSlotGapMinutes()
                        buttonGroup
                    }
                    .padding()
                }
                .navigationTitle("예약 정보 설정")
            }
            
        }
        
    }
    
    var buttonGroup: some View {
        HStack {
            if isSettingPaxFieldSatisfied && isBusinessTimeFieldSatisfied {
                Spacer()
                Button("완료") {
                    restaurantVM.createRestaurant()
                }
                .matbookingButtonStyle(width: 100, color: Color.matNature)
            }
            Spacer()
            Button("취소") {
                ownerVM.joinCancel()
            }
            .matbookingButtonStyle(width: 100, color: Color.matNature)
            Spacer()
        }
        
    }
}

struct SettingPax: View {
    
    @State var paxMin = 1
    @State var paxMax = 2
    
    @Binding var isPaxMinSatisfiedValue: Bool
    
    @State var alertMessege = ""
    
    var body: some View {
        VStack {
            Text("인원 설정")
            VStack {
                Stepper(value: $paxMin, in: 0...20) {
                    Image(systemName: "person")
                    Text("최소인원")
                    Text("\(paxMin)")
                }
                
                Stepper(value: $paxMax, in: 0...20) {
                    Image(systemName: "person.2")
                    Text("최대인원")
                    Text("\(paxMax)")
                }
                if !isPaxMinSatisfiedValue {
                    Text(alertMessege)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .onAppear {
                isPaxMinSatisfiedValue = true
            }
            .onChange(of: paxMax, perform: { newPaxMax in
                if newPaxMax < paxMin {
                    isPaxMinSatisfiedValue = false
                    alertMessege = "최대인원은 최소인원보다 많아야 합니다."
                } else {
                    isPaxMinSatisfiedValue = true
                }
            })
            .onChange(of: paxMin, perform: { newPaxMin in
                if newPaxMin > paxMax {
                    isPaxMinSatisfiedValue = false
                    alertMessege = "최소인원은 최대인원보다 많을 수 없습니다."
                } else if newPaxMin == 0{
                    isPaxMinSatisfiedValue = false
                    alertMessege = "최소인원은 0명 이상이어야 합니다."
                } else {
                    isPaxMinSatisfiedValue = true
                }
            })
        }
    }
}

struct BusinessDayView: View {
    
    let day: String
    
    @State var isWorkDay = true
    private var backgroundColor: Color {
        isWorkDay ? Color.matNature : Color.matPeach
    }
    
    @State private var startTime = Date()
    @State private var endTime = Date() + 1200
    
    @State var isEndTimeBiggerThanStartTime = false
    
    @Binding var isBusinessFieldSatisfied: Bool
    
    @State var alertMessage = ""
    
    var proxy: GeometryProxy
    
    var body: some View {
        VStack {
            HStack {
                GroupBox {
                    HStack(alignment: .center) {
                        Text(day)
                            .frame(width: proxy.size.width / 9, height: proxy.size.width / 9)
                            .font(.title3)
                            .background(backgroundColor)
                            .foregroundColor(Color.matBlack)
                            .clipShape(Circle())
                        Spacer()
                        if isWorkDay {
                            HStack {
                                Spacer()
                                DatePicker("", selection: $startTime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                                Spacer()
                                DatePicker("", selection: $endTime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                                Spacer()
                            }
                            .onAppear {
                                isBusinessFieldSatisfied = true
                            }
                            .onChange(of: endTime, perform: { newEndTime in
                                if newEndTime < startTime {
                                    isEndTimeBiggerThanStartTime = false
                                    isBusinessFieldSatisfied = false
                                    alertMessage = "영업종료시간은 시작시간보다 작을 수 없습니다."
                                } else {
                                    isEndTimeBiggerThanStartTime = true
                                    isBusinessFieldSatisfied = true
                                }
                            })
                            .onChange(of: startTime, perform: { newStartTime in
                                if newStartTime < endTime {
                                    isEndTimeBiggerThanStartTime = false
                                    isBusinessFieldSatisfied = false
                                    alertMessage = "영업시작시간은 종료시간보다 클수 없습니다."
                                } else {
                                    isEndTimeBiggerThanStartTime = true
                                    isBusinessFieldSatisfied = true
                                }
                            })
                        } else {
                            HStack {
                                Text("휴무일")
                            }
                        }
                          
                        Spacer()
                        Toggle("", isOn: $isWorkDay)
                            .tint(backgroundColor)
                    }
                  
                }
                .groupBoxStyle(TransparentGroupBox(color: isWorkDay ? Color.matWhiteGreen : Color.matLightPink))
                .animation(.default, value: backgroundColor)
                
            }
        }
        if !isEndTimeBiggerThanStartTime {
            Text(alertMessage)
                .foregroundColor(.red)
        }
      
    }
}

struct SettingSlotGapMinutes: View {
    
    let times = ["60 분", "90 분", "120 분", "150 분"]
    
    @State var selectedTime = "60 분"
    
    var body: some View {
        VStack {
            Text("다음 예약까지의 시간")
                .padding(5)
            Picker("", selection: $selectedTime) {
                ForEach(times, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            .padding()
        }
    }
}

//struct ReservationEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReservationEditView(restaurantVM: RestaurantViewModel(), myRestaurant: .constant(Restaurant(name: "", address: "", mobile: "", description: "", openTimeDescription: "")))
//            .previewInterfaceOrientation(.portrait)
//    }
//}
