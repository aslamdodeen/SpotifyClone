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
    let images: [String]
    let thumbnail: String
}

