//
//  Extensions.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/10.
//

import Foundation
import SwiftUI

// MARK: Button Style
extension Button {
    func matbookingButtonStyle(width: CGFloat, color: Color? = .blue) -> some View {
        self
            .padding()
            .frame(width: width)
            .background(color)
            .cornerRadius(10)
            .foregroundColor(.white)
    }
}

// MARK: TextField
extension TextField {
    func underlineTextField(color: Color) -> some View{
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(color)
            .padding(10)
    }
}

// MARK: Color
extension Color {
    init(r: Int, g: Int, b: Int) {
        
        self.init(red: CGFloat(r/255), green: CGFloat(g/255), blue: CGFloat(b/255))
    }
    // rgb(10, 29, 55)
    static let matBlack = Color(r: 10, g: 29, b: 55)
    // rgb(255, 189, 155)
    static let matPeach = Color(red: 255 / 255, green: 189 / 255, blue: 155 / 255)
    // rgb(255, 216, 204)
    static let matBeige = Color(red: 255, green: 216, blue: 204)
    // rgb(255, 238, 219)
    static let matSkin = Color(red: 255, green: 238, blue: 219)
}
