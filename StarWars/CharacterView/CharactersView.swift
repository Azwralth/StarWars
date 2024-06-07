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
                        CustomCell(character: character, avatarRotationDegrees: viewModel.avatarRotationDegrees, backgroundColor: CustomColor.darkerGray)
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
                .background {
                    SpaceBackgroundView()
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("Characters")
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

struct CustomCell: View {
    let character: CharacterImage
    let avatarRotationDegrees: Double
    let backgroundColor: Color
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: character.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 40, height: 40)
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                case .failure:
                    Color.red
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                @unknown default:
                    EmptyView()
                }
            }
            .rotation3DEffect(
                .degrees(avatarRotationDegrees),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
        
            Spacer()
            
            Text(character.name)
                .font(CustomTypography.body)
                .foregroundStyle(CustomColor.starWarsYellow)
            
            Spacer()
        }
        .padding()
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 30))
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
