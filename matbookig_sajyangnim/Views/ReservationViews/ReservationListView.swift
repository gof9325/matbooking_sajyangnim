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
                    displayedComponents: [.date]
                )
                .accentColor(Color.matNature)
                .datePickerStyle(.graphical)
                ScrollView {
                    LazyVStack {
                        if reservationList == nil {
                            ProgressView()
                        } else {
                            ForEach(reservationList!, id:\.self) { reservation in
                                ReservationItemView(reservation: reservation)
                            }
                        }
                    }
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
}

struct ReservationListView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationListView()
    }
}
