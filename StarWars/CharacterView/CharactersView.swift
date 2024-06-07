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
        ZStack {
            NavigationStack {
                List(viewModel.characters, id: \.name) { character in
                    NavigationLink { DetailView(viewModel: DetailViewViewModel(), characterName: character.name, characterImage: character.image)
                    } label: {
                        CustomCellView(character: character, avatarRotationDegrees: viewModel.avatarRotationDegrees, backgroundColor: CustomColor.darkerGray)
                            .navigationLinkArrow(color: CustomColor.starWarsYellow)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(CustomColor.clear)
                    .onAppear {
                        viewModel.startAvatarRotation()
                    }
                }
                .listStyle(.grouped)
                .scrollContentBackground(.hidden)
                .listRowSpacing(1)
                .listRowInsets(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
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
                    viewModel.fetchCharacters(from: Link.characterUrl.url)
                }
            }
        }
    }
}

struct NavigationLinkArrowModifier: ViewModifier {
    var color: Color

    func body(content: Content) -> some View {
        HStack {
            content
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(color)
                .font(.system(size: 20, weight: .bold))
        }
    }
}

extension View {
    func navigationLinkArrow(color: Color) -> some View {
        self.modifier(NavigationLinkArrowModifier(color: color))
    }
}

#Preview {
    CharactersView(viewModel: CharactersViewViewModel())
}
