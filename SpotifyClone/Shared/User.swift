//
//  User.swift
//  SpotifyClone
//
//  Created by Islam Aldarabea on 24/01/2025.
//

// MARK: - Welcome
struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
}

// MARK: - User
struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName : String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height, weight: Double
  
}
