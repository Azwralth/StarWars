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
            ZStack {
                SpaceBackgroundView()
                ScrollView {
                    VStack {
                        if let image = viewModel.image {
                            Image(uiImage: image)
                                .resizable()
                                .clipShape(Circle())
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 250, height: 250)
                        } else {
                            DefaultImageView(width: 250, height: 250)
                        }
                        Text(viewModel.characterName)
                            .frame(width: 250)
                            .font(CustomTypography.custom(size: 20))
                            .foregroundStyle(CustomColor.starWarsYellow)
                            .padding(.top, 30)
                        
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
                                .frame(width: 320)
                                .font(CustomTypography.body)
                                .foregroundStyle(CustomColor.white)
                                .padding(.top, 10)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 200)
                    .padding(.bottom, 100)
                    .navigationBarBackButtonHidden(true)
                    .onAppear {
                        Task {
                            await viewModel.fetchCharacter(searchName: viewModel.characterName)
                            await viewModel.fetchImage(from: viewModel.characterImage)
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
                .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    DetailView(viewModel: DetailViewViewModel(characterName: "Luke", characterImage: "", characterDescription: "123", networkManager: NetworkManagerAsyncAwait()))
}
