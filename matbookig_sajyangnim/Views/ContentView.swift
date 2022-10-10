//
//  ContentView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/07.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var UserVM: UserViewModel
    
    var body: some View {
        if UserVM.auth0User != nil {
            EmptyView()
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
