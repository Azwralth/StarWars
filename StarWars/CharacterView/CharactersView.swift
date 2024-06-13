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
        NavigationStack {
            ZStack {
                List(viewModel.characters, id: \.name) { character in
                    NavigationLink { DetailView(viewModel: DetailViewViewModel(characterName: character.name, characterImage: character.image, characterDescription: character.description))
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
                        Text("charactersNavigationTitle")
                            .font(CustomTypography.custom(size: 30))
                            .foregroundStyle(CustomColor.starWarsYellow)
                    }
                }
                .toolbarBackground(CustomColor.darkerGray, for: .navigationBar)
                .onAppear {
                    if viewModel.characters.isEmpty {
                        withAnimation {
                            viewModel.fetchCharacters(from: Link.characterImageUrl.url)
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack {
                            ButtonPage(pointingDirection: .left, isDisabled: viewModel.isFirstPage(), action: viewModel.fetchPrevPageCharacter)
                            Text(viewModel.currentPage.formatted())
                                .font(CustomTypography.h1)
                            ButtonPage(pointingDirection: .right, isDisabled: viewModel.isLastPage(), action: viewModel.fetchNextPageCharacter)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CharactersView(viewModel: CharactersViewViewModel())
}
