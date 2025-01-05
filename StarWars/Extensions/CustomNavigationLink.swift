//
//  CustomNavigationLink.swift
//  StarWars
//
//  Created by Владислав Соколов on 04.01.2025.
//

import SwiftUI

struct CustomNavigationLink<Label: View, Destination: View>: View {
    let label: Label
    let destination: Destination

    init(@ViewBuilder label: () -> Label,
         @ViewBuilder destination: () -> Destination) {
        self.label = label()
        self.destination = destination()
    }

    var body: some View {
        ZStack {
            NavigationLink {
                self.destination
            } label: {
                EmptyView()
            }
            .opacity(0)

            self.label
        }
    }
}
