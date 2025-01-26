//
//  ImageTitleRowCell.swift
//  SpotifyClone
//
//  Created by Islam Aldarabea on 26/01/2025.
//

import SwiftUI

struct ImageTitleRowCell: View {
    
    var imageSize: CGFloat = 100
    var imageName: String = Constants.randomImage
    var title: String = "Some Item Name"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize , height: imageSize)
            Text(title)
                .font(.headline)
                .foregroundStyle(.spotifyLightGray)
                .padding(4)
                .lineLimit(2)
                    }
        .frame(width: imageSize)


    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        ImageTitleRowCell()
    }
}
