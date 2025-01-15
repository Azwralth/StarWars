//
//  CustomCellView.swift
//  StarWars
//
//  Created by Владислав Соколов on 07.06.2024.
//
import SwiftUI

struct CustomCellView: View {
    @StateObject var viewModel: CustomCellViewViewModel
    
    var body: some View {
        HStack {
            VStack {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                } else {
                    DefaultImageView(width: 40, height: 40)
                }
            }
            .padding(.all, 7)
            .rotation3DEffect(
                .degrees(viewModel.avatarRotationDegrees),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .onAppear {
                viewModel.startAvatarRotation()
                Task {
                    await viewModel.fetchImage(from: viewModel.character?.image ?? "")
                }
            }
            
            Spacer()
            
            Text(viewModel.character?.name ?? "")
                .font(CustomTypography.body)
                .foregroundStyle(CustomColor.starWarsYellow)
            
            Spacer()
        }
        .background(CustomColor.darkerGray)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}


