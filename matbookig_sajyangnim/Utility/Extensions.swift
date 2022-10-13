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
        self.init(red: Double(r) / 255.0, green: Double(g) / 255.0, blue: Double(b) / 255.0)
        // Double(g / 255)
        // Double(189 / 255)
        // Double(0)
        // 0
    }
    // rgb(10, 29, 55)
    static let matBlack = Color(r: 10, g: 29, b: 55)
    // rgb(255, 189, 155)
    static let matPeach = Color(r: 255, g: 189, b: 155)
    // rgb(255, 216, 204)
    static let matBeige = Color(r: 255, g: 216, b: 204)
    // rgb(255, 238, 219)
    static let matSkin = Color(r: 255, g: 238, b: 219)
    // rgb(255, 242, 242)
    static let matLightPink = Color(r: 255, g: 242, b: 242)
    
    // rgb(116, 180, 155)
    static let matNature = Color(r: 116, g: 180, b: 155)
    // rgb(244, 249, 244)
    static let matWhiteGreen = Color(r: 244, g: 249, b: 244)
    // rgb(167, 215, 197)
    static let matGreen = Color(r: 167, g: 215, b: 197)
    // rgb(92, 141, 137)
    static let matHavyGreen = Color(r: 92, g: 141, b: 137)
}

