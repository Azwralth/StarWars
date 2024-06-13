//
//  DetailView.swift
//  StarWars
//
//  Created by Владислав Соколов on 04.06.2024.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                SpaceBackgroundView()
                VStack(alignment: .center) {
                    if let image = viewModel.image {
                        Image(uiImage: image)
                            .resizable()
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width / 3, height: geometry.size.height / 3)
                    } else {
                        DefaultImageView(width: geometry.size.width / 3, height: geometry.size.height / 3)
                    }
                    Text(viewModel.characterName)
                        .font(CustomTypography.custom(size: 20))
                        .foregroundStyle(CustomColor.starWarsYellow)
                        .padding(.top, 30)
                        .frame(width: geometry.size.width / 1.4)
                    
                    if viewModel.hasCharacterDetails {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(localizedStringKey: "characterDetailedBirth", argument: viewModel.character?.birthYear)
                                .font(CustomTypography.body)
                                .foregroundStyle(CustomColor.white)
                            Text(localizedStringKey: "characterDetailedHair", argument: viewModel.character?.hairColor)
                                .font(CustomTypography.body)
                                .foregroundStyle(CustomColor.white)
                            
                            Text(localizedStringKey: "characterDetailedHeight", argument: viewModel.character?.height)
                                .font(CustomTypography.body)
                                .foregroundStyle(CustomColor.white)
                        }
                        .padding(.top, 10)
                    } else {
                        Text(viewModel.characterDescription)
                            .frame(width: geometry.size.width / 1.1)
                            .font(CustomTypography.body)
                            .foregroundStyle(CustomColor.white)
                            .padding(.top, 10)
                    }
                    
                    Spacer()
                }
                .navigationBarBackButtonHidden(true)
                .padding(.leading, -140)
                .onAppear {
                    viewModel.fetchCharacter(searchName: viewModel.characterName)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(CustomColor.starWarsYellow)
                            .font(.system(size: 20, weight: .bold))
                    }
                    .padding(.trailing, 10)
                }
            }
        }
    }
}

#Preview {
    DetailView(viewModel: DetailViewViewModel(characterName: "", characterImage: "", characterDescription: "123"))
}
