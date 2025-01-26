//
//  SpotifyHomeView.swift
//  SpotifyClone
//
//  Created by Islam Aldarabea on 25/01/2025.
//

import SwiftUI
import SwiftfulUI

struct SpotifyHomeView: View {
    
    @State private var currentUser: User? = nil
    @State private var products: [Product] = []
    
    @State private var selectedCategory: Category? = nil
    @State private var selectedProduct: Product? = nil
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.edgesIgnoringSafeArea(.all)
            ScrollView(.vertical) {
                LazyVStack(
                    spacing: 1,
                    pinnedViews: [.sectionHeaders],
                    content: {
                        Section {
                            VStack(spacing: 21) {
                                itemProduct
                                if let product = products.first {
                                    newReelaseSection(product: product)
                                }
                                
                            }
                          
                        } header: {
                            header
                        }
                    })
                .padding(.top, 8)
            }
            .scrollIndicators(.hidden)
            .clipped()
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func newReelaseSection(product: Product) -> some View {
        SpotifyNewReleaseCell(
            imageName: product.thumbnail,
            headline: "",
            subheadline: product.title,
            title: product.title,
            subtitle: product.description) {
            } onPlayPressed: {
                
            }
    }
    
    private var itemProduct: some View {
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 12, items: products) { item in
            
            SpotifyRecentsCell(imageName: item?.thumbnail ?? "", title: item?.title ?? "", isSelected:                                      selectedProduct == item
            )
            .padding(.top, 16)
            .onTapGesture {
                selectedProduct = item
            }
        }
    }
    
    private var header: some View {
        
        HStack(spacing: 0) {
            ZStack {
                if let currentUser {
                    ImageLoaderView(urlString: currentUser.image)
                        .background(.spotifyWhite)
                        .clipShape(Circle())
                        .onTapGesture {
                        }
                }
            }
            .frame(width: 36, height: 36)
            
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(Category.allCases, id: \.self) { category in
                        SpotifyCategoryCell(title: category.rawValue.capitalized, isSelected: category == selectedCategory)
                            .onTapGesture {
                                selectedCategory = category
                            }
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .background(Color.spotifyBlack)
    }
    
    private func getData() async {
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            products = try await Array(DatabaseHelper().getproducts().prefix(8))
            
        } catch {
            print("err\(error)")
        }
    }
}

#Preview {
    SpotifyHomeView()
}

