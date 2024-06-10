//
//  PageButtonView.swift
//  StarWars
//
//  Created by Владислав Соколов on 07.06.2024.
//

import SwiftUI

enum PointingDirection: String {
    case left
    case right
}

struct PageButtonView: View {
    let pointingDirection: PointingDirection
    let isDisabled: Bool
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "arrowtriangle.\(pointingDirection).fill")
                .foregroundColor(CustomColor.white)
                .opacity(isDisabled ? 0.3 : 1.0)
        }
        .disabled(isDisabled)
    }
}
