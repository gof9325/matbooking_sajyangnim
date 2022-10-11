//
//  matbookig_sajyangnimApp.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/07.
//

import SwiftUI

@main
struct matbookig_sajyangnimApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(OwnerViewModel(from: ""))
        }
    }
}
