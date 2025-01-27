//
//  Product.swift
//  SpotifyClone
//
//  Created by Islam Aldarabea on 24/01/2025.
//

import Foundation

// MARK: - Welcome
struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

// MARK: - Product
struct Product: Codable, Identifiable, Equatable {
    let id: Int
    let title, description: String
    let price, discountPercentage, rating: Double
    let stock: Int
    let brand: String?
    let category: String
    let images: [String]
    let thumbnail: String
    
    static var mock: Product {
        Product(
            id: 123,
            title: "Example product title",
            description: "This is some mock product description that goes here",
            price: 999,
            discountPercentage: 23,
            rating: 4.6,
            stock: 55,
            brand: "Apple",
            category: "Electronic Deveices",
            images: [Constants.randomImage, Constants.randomImage],
            thumbnail:Constants.randomImage
        )
    }
}



struct ProductRow: Identifiable {
    let id = UUID().uuidString
    let title: String
    let products: [Product]
    
}

