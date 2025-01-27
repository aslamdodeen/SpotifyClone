//
//  PlayListHeaderCell.swift
//  SpotifyClone
//
//  Created by Islam Aldarabea on 27/01/2025.
//

import SwiftUI
import SwiftfulUI

struct PlayListHeaderCell: View {
    
    var hieght: CGFloat = 332
    var title: String = "Some playlist title goes here"
    var subtitle: String = "Subtitle goes here"
    var imageName: String = Constants.randomImage
    var shadowColor: Color = .spotifyBlack.opacity(0.8)
    
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay {
                ImageLoaderView(urlString: imageName)
            }
            .overlay(
                VStack(alignment: .leading,spacing: 8) {
                    Text(subtitle)
                        .font(.headline)
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                }
                    .foregroundStyle(.spotifyWhite)
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        LinearGradient(colors: [shadowColor.opacity(0.01), shadowColor], startPoint: .top, endPoint: .bottom)
                    )
                ,alignment: .bottomLeading
            )
            .asStretchyHeader(startingHeight: 332)
            .frame(height: 300)
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        ScrollView {
            PlayListHeaderCell()
        }
        .ignoresSafeArea()
    }
}
