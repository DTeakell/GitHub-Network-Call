//
//  HomeView.swift
//  GitHub-Network-Call
//
//  Created by Dillon Teakell on 12/4/24.
//

import SwiftUI

struct HomeView: View {
    
    // Create an instance of the GitHubUserManager
    
    @State private var user: GitHubUser?
    @State private var userName: String = ""
    let userManager = GitHubUserManager(userName: "")
    
    @MainActor
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Enter GitHub Username", text: $userName)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                
                Button ("Get User") {
                    print(user?.login ?? "User ID")
                }
                .buttonStyle(.borderedProminent)
                .tint(Color(uiColor: .systemPurple))
                .disabled(userName.isEmpty)
                .task {
                    do {
                        user = try await userManager.getUser(userName: userName)
                    } catch GitHubUserManagerError.invalidData {
                        print("")
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Find User")
        }
    }
}

#Preview {
    HomeView()
}
