//
//  SongRowCell.swift
//  SpotifyClone
//
//  Created by Islam Aldarabea on 27/01/2025.
//

import SwiftUI

struct SongRowCell: View {
    
    var imageSize: CGFloat = 100
    var imageName: String = Constants.randomImage
    var title: String = "some song name "
    var subtitle: String? = "Some artist name"
    var onCellressed: (() -> Void)? = nil
    var onEllipsisTapped: (() -> Void)? = nil
    
    
    
    var body: some View {
        HStack(spacing: 8) {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.spotifyWhite)
                
                if let subtitle {
                    Text(subtitle)
                        .font(.callout)
                        .foregroundStyle(.spotifyLightGray)
                }
            }
            .lineLimit(2)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "ellipsis")
                .font(.subheadline)
                .foregroundStyle(.spotifyWhite)
                .padding(16)
                .background(.black.opacity(0.001))
                .onTapGesture {
                    onEllipsisTapped?()
                }
            
        }
        .onTapGesture {
            onCellressed?()
        }
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        VStack {
            SongRowCell()
            SongRowCell()
            SongRowCell()
            SongRowCell()
        }
    }
}
