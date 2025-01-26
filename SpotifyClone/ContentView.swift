//
//  ContentView.swift
//  SpotifyClone
//
//  Created by Islam Aldarabea on 24/01/2025.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct ContentView: View {
    
    @State private var users: [User] = []
    @State private var product: [Product] = []
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(product) { user in
                    Text(user.title)
                        .foregroundStyle(.spotifyGreen)
                }
            }
        }
        .task {
            await fetchUsers()
        }
        .padding()
    }
    
    private func fetchUsers() async {
        do {
            users = try await DatabaseHelper().getUsers()
            product = try await DatabaseHelper().getproducts()
            print(product)
            

        } catch {
            print("err\(error)")
        }
    }
}

#Preview {
    ContentView()
}
