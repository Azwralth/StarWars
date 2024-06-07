//
//  DetailView.swift
//  StarWars
//
//  Created by Владислав Соколов on 04.06.2024.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewViewModel
    let characterName: String
    let characterImage: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                SpaceBackgroundView()
                VStack(alignment: .center) {
                    AsyncImage(url: URL(string: characterImage)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .clipShape(Circle())
                                .shadow(radius: 90)
                        case .failure(_):
                            Color.red
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 256, height: 256)
                    .padding(.top, 100)
                    Text(characterName)
                        .font(CustomTypography.custom(size: 20))
                        .foregroundStyle(CustomColor.starWarsYellow)
                        .padding(.top, 30)
                        .frame(width: geometry.size.width / 1.4)
                    
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
                    
                    Spacer()
                }
                .navigationBarBackButtonHidden(true)
                .padding(.leading, -140)
                .onAppear {
                    viewModel.fetchCharacter(searchName: characterName)
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
    DetailView(viewModel: DetailViewViewModel(), characterName: "Darth Vader", characterImage: "https://lumiere-a.akamaihd.net/v1/images/databank_aaylasecura_01_169_39a65af2.jpeg")
}
