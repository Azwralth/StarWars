//
//  CustomCellView.swift
//  StarWars
//
//  Created by Владислав Соколов on 07.06.2024.
//

import SwiftUI

struct CustomCellView: View {
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

#Preview {
    CustomCellView(character: CharacterImage.init(image: "", name: "", description: ""), avatarRotationDegrees: 0.0, backgroundColor: .darkerGray)
}
