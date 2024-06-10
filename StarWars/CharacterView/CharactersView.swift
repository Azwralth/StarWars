//
//  ContentView.swift
//  StarWars
//
//  Created by Владислав Соколов on 04.06.2024.
//

import SwiftUI

struct CharactersView: View {
    @ObservedObject var viewModel: CharactersViewViewModel
    
    var body: some View {
        VStack {
            NavigationStack {
                List(viewModel.characters, id: \.name) { character in
                    NavigationLink { DetailView(viewModel: DetailViewViewModel(characterName: character.name, characterImage: character.image))
                    } label: {
                        CustomCellView(viewModel: CustomCellViewViewModel(character: character))
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(CustomColor.clear)
                }
                .listStyle(.grouped)
                .scrollContentBackground(.hidden)
                .background {
                    SpaceBackgroundView()
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text(localizedStringKey: "charactersNavigationTitle")
                            .font(CustomTypography.custom(size: 30))
                            .foregroundStyle(CustomColor.starWarsYellow)
                    }
                }
                .toolbarBackground(CustomColor.darkerGray, for: .navigationBar)
                .onAppear {
                    viewModel.fetchCharacters(from: Link.characterImageUrl.url)
                }
            }
        }
    }
}

#Preview {
    CharactersView(viewModel: CharactersViewViewModel())
}
