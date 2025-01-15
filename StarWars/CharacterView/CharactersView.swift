//
//  ContentView.swift
//  StarWars
//
//  Created by Владислав Соколов on 04.06.2024.
//

import SwiftUI

struct CharactersView: View {
    @StateObject private var viewModel = CharactersViewViewModel(networkManager: NetworkManagerAsyncAwait())
    
    var body: some View {
        NavigationStack {
            List(viewModel.characters, id: \.name) { character in
                CustomNavigationLink {
                    CustomCellView(viewModel: CustomCellViewViewModel(character: character, networkManager: NetworkManagerAsyncAwait()))
                } destination: {
                    DetailView(viewModel: DetailViewViewModel(
                        characterName: character.name,
                        characterImage: character.image,
                        characterDescription: character.description,
                        networkManager: NetworkManagerAsyncAwait()
                    ))
                }
                .listRowBackground(CustomColor.clear)
            }
            .onAppear {
                Task {
                    await viewModel.fetchCharacters(from: viewModel.currentPage)
                }
            }
            .listStyle(.grouped)
            .scrollContentBackground(.hidden)
            .background {
                SpaceBackgroundView()
            }
            .toolbarBackground(CustomColor.darkerGray, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("charactersNavigationTitle")
                        .font(CustomTypography.custom(size: 30))
                        .foregroundStyle(CustomColor.starWarsYellow)
                }
                ToolbarItem(placement: .bottomBar) {
                    buttonsPage()
                }
            }
        }
    }
    @ViewBuilder
    func buttonsPage() -> some View {
        HStack {
            ButtonPage(
                pointingDirection: .left,
                isDisabled: viewModel.isFirstPage(),
                action: {
                    Task {
                        await viewModel.fetchPrevPageCharacter()
                    }
                }
            )
            Text(viewModel.currentPage.formatted())
                .font(CustomTypography.h1)
            ButtonPage(
                pointingDirection: .right,
                isDisabled: viewModel.isLastPage(),
                action: {
                    Task {
                        await viewModel.fetchNextPageCharacter()
                    }
                }
            )
        }
    }
}


#Preview {
    CharactersView()
}
