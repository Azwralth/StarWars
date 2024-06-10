//
//  ImageView.swift
//  StarWars
//
//  Created by Владислав Соколов on 10.06.2024.
//

import SwiftUI

struct DefaultImageView: View {
    let width: CGFloat
    let height: CGFloat    
    
    var body: some View {
        HStack {
            Image("StarWarsQuestionMark")
                .resizable()
                .clipShape(Circle())
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
        }
    }
}
