//
//  ContentView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/07.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userVM: UserViewModel
    @State var user: User?
    
    var body: some View {
        VStack {
            if self.user != nil {
                Text("asdfsdf")
            } else {
                LoginView()
            }
        }.onReceive(userVM.$user, perform: {self.user = $0})
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
