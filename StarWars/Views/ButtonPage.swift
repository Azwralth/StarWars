//
//  ButtonPage.swift
//  StarWars
//
//  Created by Владислав Соколов on 05.01.2025.
//

import SwiftUI

enum PointingDirection: String {
    case left
    case right
}

struct ButtonPage: View {
    let pointingDirection: PointingDirection
    let isDisabled: Bool
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "arrowtriangle.\(pointingDirection).fill")
                .foregroundColor(CustomColor.starWarsYellow)
                .opacity(isDisabled ? 0.3 : 1.0)
        }
        .disabled(isDisabled)
    }
}
