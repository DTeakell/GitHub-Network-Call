//
//  GitHubUserView.swift
//  GitHub-Network-Call
//
//  Created by Dillon Teakell on 12/5/24.
//

import SwiftUI

struct GitHubUserView: View {
    @Binding var user: GitHubUser?
    var body: some View {
        NavigationStack {
            VStack {
                // Image View
                AsyncImage(url: user?.avatarUrl ?? URL(filePath: "")) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    
                } placeholder: {
                    ZStack {
                        Circle()
                            .frame(width: 100, height: 100)
                            .foregroundStyle(Color.secondary)
                        
                        Image(systemName: "person.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45, height: 45)
                            .foregroundStyle(Color.white)
                    }
                }
                // User Name
                Text(user?.name ?? "")
                    .font(.title)
                    .fontWeight(.semibold)
                
                // Follow Metrics
                HStack {
                    HStack {
                        Text("Followers:")
                            .font(.subheadline)
                        
                        Text("\(user?.followers ?? 0)")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                    }
                    
                    HStack {
                        Text("Followers:")
                            .font(.subheadline)
                        
                        Text("\(user?.followers ?? 0)")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                    }
                }
                
                
                Text(user?.bio ?? "Placeholder bio")
                    .padding()
                
                Spacer()
                
            }
            .navigationTitle(user?.login ?? "User Login")
        }
    }
}

#Preview {
    NavigationStack {
        GitHubUserView(
            user:
                    .constant(
                        GitHubUser(
                            login: "Login",
                            name: "Dillon Teakell",
                            avatarUrl: URL(""),
                            url: URL(""),
                            bio: "Placeholder bio",
                            followers: 0,
                            following: 123
                        )
                    )
        )
    }
}
