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
    func matbookingButtonStyle(width: CGFloat) -> some View {
        self
            .padding()
            .frame(width: width)
            .background(.blue)
            .cornerRadius(10)
            .foregroundColor(.white)
    }
}
