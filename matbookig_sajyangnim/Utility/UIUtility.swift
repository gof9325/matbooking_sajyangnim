//
//  UIUtility.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/12.
//

import Foundation
import SwiftUI

// MARK: View

struct ImageSlider: View {

    @State var images: [String]
    
    var body: some View {
        TabView {
            ForEach(images, id: \.self) { item in
                 Image(systemName: item)
                    .resizable()
                    .scaledToFill()
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct TransparentGroupBox: GroupBoxStyle {
    
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .frame(maxWidth: .infinity)
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).fill(color))
            .overlay(configuration.label.padding(.leading, 4), alignment: .topLeading)
    }
}
