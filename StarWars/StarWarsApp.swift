//
//  StarWarsApp.swift
//  StarWars
//
//  Created by Владислав Соколов on 04.06.2024.
//

import SwiftUI

@main
struct StarWarsApp: App {
    @EnvironmentObject var charactersViewVM: CharactersViewViewModel
    var body: some Scene {
        WindowGroup {
            CharactersView(viewModel: CharactersViewViewModel())
                .environmentObject(charactersViewVM)
        }
    }
}

