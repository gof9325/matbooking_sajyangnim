//
//  ReservationListView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/11.
//

import SwiftUI

struct ReservationListView: View {
    
    @State var reservationList = ["a", "b"]
    @State var date = Date()
    
    var body: some View {
        VStack {
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
                        ForEach(reservationList, id:\.self) { reservation in
                            ReservationItemView()
                        }
                    }
                }
            }
        }
        .padding()
    }
}

struct ReservationListView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationListView()
    }
}
