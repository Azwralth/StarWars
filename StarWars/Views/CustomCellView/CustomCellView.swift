//
//  CustomCellView.swift
//  StarWars
//
//  Created by Владислав Соколов on 07.06.2024.
//

import SwiftUI

struct CustomCellView: View {
    @ObservedObject var viewModel: CustomCellViewViewModel
    
    var body: some View {
        HStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .padding(.all, 9)
                    .rotation3DEffect(
                        .degrees(viewModel.avatarRotationDegrees),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
            } else {
                DefaultImageView(width: 40, height: 40)
                    .padding(.all, 9)
                    .rotation3DEffect(
                        .degrees(viewModel.avatarRotationDegrees),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
            }
            
            Spacer()
            
            Text(viewModel.character?.name ?? "")
                .font(CustomTypography.body)
                .foregroundStyle(CustomColor.starWarsYellow)
            
            Spacer()
        }
        .onAppear {
            viewModel.startAvatarRotation()
        }
        .background(viewModel.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}
