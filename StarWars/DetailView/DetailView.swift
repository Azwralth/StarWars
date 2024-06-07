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
                VStack {
                    Text("Profile")
                        .font(CustomTypography.custom(size: 40))
                        .foregroundStyle(CustomColor.starWarsYellow)
                        .padding(.top, 30)
                    Spacer()
                    AsyncImage(url: URL(string: characterImage)) { image in
                        image.image?.resizable()
                    }
                    .frame(width: geometry.size.width / 1.4, height: geometry.size.height / 3.9)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 90)
                    .padding(.top, -250)
                    Text(characterName)
                        .font(CustomTypography.body)
                        .foregroundStyle(CustomColor.starWarsYellow)
                        .lineLimit(1)
                    HStack {
                        Text(viewModel.character?.height ?? "")
                            .font(CustomTypography.body)
                            .foregroundStyle(CustomColor.white)
                        
                        Text(viewModel.character?.gender ?? "")
                            .font(CustomTypography.body)
                            .foregroundStyle(CustomColor.white)
                    }
                    Spacer()
                }
                .navigationBarBackButtonHidden(true)
                .padding(.leading, -25)
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
