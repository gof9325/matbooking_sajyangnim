//
//  ReservationEditView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/13.
//

import SwiftUI

struct ReservationEditView: View {
    @EnvironmentObject var ownerVM: OwnerViewModel
    
    @State var days = ["월", "화", "수", "목", "금", "토", "일"]
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ScrollView {
                    
                    SettingPax()
                        .padding([.top, .bottom])
                    
                    VStack {
                        Text("영업날짜 & 시간")
                        HStack {
                            VStack{
                                ForEach(days, id:\.self) { day in
                                    BusinessDayView(day: day, isSelected: .constant(true), proxy: proxy)
                                }
                            }
                            .padding([.top, .bottom])
                        }
                    }
                    .padding([.top, .bottom])
                    buttonGroup
                }
                .padding()
            }
            .navigationTitle("예약 정보 설정")
        }
        
    }
    
    var buttonGroup: some View {
        
        HStack {
            Spacer()
            Button("완료") {
                // addRestaurant
            }
            .matbookingButtonStyle(width: 100, color: Color.matNature)
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
    @State var paxMax = 1
    
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
            }
        }
    }
    
}

struct BusinessDayView: View {
    
    let day: String
    
    @State var isWorkDay = true
    
    @State private var startTime = Date()
    @State private var endTime = Date() + 1200
    
    @Binding var isSelected: Bool
    
    var proxy: GeometryProxy
    
    var body: some View {
        HStack {
            GroupBox {
                HStack(alignment: .center, spacing: 30) {
                    Button(day) {
                        isSelected = false
                    }
                    .frame(width: proxy.size.width / 9, height: proxy.size.width / 9)
                    .font(.title3)
                    .background(isWorkDay ? Color.matNature : Color.matPeach)
                    .foregroundColor(Color.matBlack)
                    .clipShape(Circle())
                    if isWorkDay {
                        HStack {
                            DatePicker("", selection: $startTime, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                            Spacer()
                            DatePicker("", selection: $endTime, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                        }
                    } else {
                        HStack {
                            Text("휴무일")
                        }
                    }
                    Toggle("", isOn: $isWorkDay)
                        .tint(isWorkDay ? Color.matNature : Color.matPeach)
                }
            }
            .groupBoxStyle(TransparentGroupBox(color: isWorkDay ? Color.matWhiteGreen : Color.matLightPink))
        }
    }
}


struct ReservationEditView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationEditView()
    }
}
