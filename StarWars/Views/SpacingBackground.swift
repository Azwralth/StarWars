//
//  SpacingBackground.swift
//  StarWars
//
//  Created by Владислав Соколов on 05.01.2025.
//

import SwiftUI

struct SpaceBackgroundView: View {
    var body: some View {
        ZStack {
            Image("stars")
                .edgesIgnoringSafeArea(.vertical)
                .opacity(0.9)
            LinearGradient(gradient: Gradient(colors: [CustomColor.clear, CustomColor.black, CustomColor.darkerGray]), startPoint: .top, endPoint: .bottom)
        }
    }
}
