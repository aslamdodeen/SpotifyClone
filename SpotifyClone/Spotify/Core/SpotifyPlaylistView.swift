//
//  SpotifyPlaylistView.swift
//  SpotifyClone
//
//  Created by Islam Aldarabea on 27/01/2025.
//

import SwiftUI

struct SpotifyPlaylistView: View {
    
    var product: Product = .mock
    var user: User = .mock
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    PlayListHeaderCell(hieght: 200, title: "J.S. Bach: Goldberg Variations BWV 988", subtitle: "J.S.Bach", imageName: product.thumbnail, shadowColor: .spotifyBlack)
                    
                    PlaylistDescriptionCell(
                        descriptionText: product.description,
                        userName: user.firstName,
                        subheadline: product.category,
                        onAddToPlayListPressed: nil,
                        onDownloadPressed: nil,
                        onSharePressed: nil,
                        onAEllipsisPressed: nil,
                        onShufflePressed: nil,
                        onPlayPressed: nil
                    )
                    .padding(.horizontal, 16)
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    SpotifyPlaylistView()
}
