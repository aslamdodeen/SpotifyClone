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
    @State private var productRows: [ProductRow] = []
    
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
                                    .padding(.horizontal, 16)
                                if let product = products.last {
                                    newReelaseSection(product: product)
                                        .padding(.horizontal, 16)
                                }
                                listRows
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
            headline: product.brand,
            subheadline: product.category,
            title: product.title,
            subtitle: product.description) {
            } onPlayPressed: {
                
            }
    }
    
    private var itemProduct: some View {
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 12, items: products) { item in
            
            SpotifyRecentsCell(imageName: item?.thumbnail ?? "", title: item?.title ?? "", isSelected:                                      selectedProduct == item
            )
            .asButton(.press) {
                
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
    
    private var listRows: some View {
        ForEach(productRows) { row in
            VStack(spacing: 12) {
                Text(row.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.spotifyWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(row.products) { product in
                            ImageTitleRowCell(
                                imageSize: 120,
                                imageName: product.thumbnail,
                                title: product.title
                            )
                            .asButton(.press) {
                                
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    private func getData() async {
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            products = try await Array(DatabaseHelper().getproducts().prefix(8))
            
            var rows: [ProductRow] = []
            let allBrands = Set(products.map({$0.brand}))
            for brand in allBrands {
                //  let products = self.products.filter({$0.brand == brand})
                rows.append(ProductRow(title: brand ?? "", products: products))
            }
            productRows = rows
        } catch {
            print("err\(error)")
        }
    }
}

#Preview {
    SpotifyHomeView()
}

