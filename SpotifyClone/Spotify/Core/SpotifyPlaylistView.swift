//
//  SpotifyPlaylistView.swift
//  SpotifyClone
//
//  Created by Islam Aldarabea on 27/01/2025.
//

import SwiftUI
import SwiftfulUI

struct SpotifyPlaylistView: View {
    
    var product: Product = .mock
    var user: User = .mock
    
    @State private var products: [Product] = []
    @State private var showHeader: Bool = true
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    
                    PlayListHeaderCell(hieght: 200, title: "J.S. Bach: Goldberg Variations BWV 988", subtitle: "J.S.Bach", imageName: product.thumbnail, shadowColor: .spotifyBlack)
                        .readingFrame { frame in
                          showHeader = frame.maxY < 150
                        }
                    
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
                    
                    ForEach(products) { product in
                        SongRowCell(
                            imageSize: 50,
                            imageName: product.thumbnail,
                            title: product.title,
                            subtitle: product.brand,
                            onCellressed: nil,
                            onEllipsisTapped: nil
                        )
                        .padding(.leading, 16)
                    }
                }
            }
            .scrollIndicators(.hidden)
            
            
            ZStack {
                Text(product.title)
                    .font(.headline)
                    .foregroundStyle(.spotifyWhite)
                    .padding(.vertical, 21)
                    .frame(maxWidth: .infinity)
                    .background(.spotifyBlack)
                    .offset(y: showHeader ? 0 : -32)
                    .opacity(showHeader ? 1 : 0)
                
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .padding(12)
                    .background( showHeader ? Color.spotifyBlack.opacity(0.001) : Color.spotifyGray.opacity(0.7))
                    .clipShape(Circle())
                    .onTapGesture {
                    }
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
            }
            .foregroundStyle(.spotifyWhite)
            .animation(.smooth(duration:0.2), value: showHeader)
            .frame(maxHeight: .infinity, alignment: .top)
            
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        do {
            products = try await Array(DatabaseHelper().getproducts())
        } catch {
            print("err\(error)")
        }
    }
}

#Preview {
    SpotifyPlaylistView()
}
