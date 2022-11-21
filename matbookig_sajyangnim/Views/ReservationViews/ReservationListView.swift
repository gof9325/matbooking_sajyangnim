//
//  ReservationListView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/11.
//

import SwiftUI

struct ReservationListView: View {
    
    @StateObject var reservationVM = ReservationViewModel()
    
    @State var reservationList: [Reservation]?
    @State var date = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker(
                    "start Date",
                    selection: $date,
                    in: Date()...,
                    displayedComponents: [.date]
                )
                .accentColor(Color.matNature)
                .datePickerStyle(.graphical)
                VStack {
                    Spacer()
                    switch reservationVM.reservationLoadingState {
                    case .beforeLoaded:
                        ProgressView()
                    case .didLoaded, .loadSuccess:
                        ScrollView {
                            LazyVStack {
                                ForEach(reservationList!, id:\.self) { reservation in
                                    ReservationItemView(reservation: reservation)
                                }
                            }
                        }
                    case .loadFail:
                        Text("로딩실패")
                    }
                    Spacer()
                }
            }
            .navigationTitle("예약목록")
            .onAppear {
                reservationVM.getReservations()
            }
            .onReceive(reservationVM.$reservationList, perform: {
                if $0 != nil {reservationList = $0}
            })
            .padding()
        }
    }
    
    struct ReservationListView_Previews: PreviewProvider {
        static var previews: some View {
            ReservationListView()
        }
    }
}
