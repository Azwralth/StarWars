//
//  SpacingBackground.swift
//  StarWars
//
//  Created by Владислав Соколов on 06.06.2024.
//


import SwiftUI

struct SpaceBackgroundView: View {
    var body: some View {
        ZStack {
            Image("stars")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.9)
            LinearGradient(gradient: Gradient(colors: [CustomColor.black,
                                                       CustomColor.darkerGray,
                                                       CustomColor.clear]),
                           startPoint: .bottom,
                           endPoint: .bottom)
        }
    }
}

#Preview {
    SpaceBackgroundView()
}
