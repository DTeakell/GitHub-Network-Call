//
//  GitHubUserView.swift
//  GitHub-Network-Call
//
//  Created by Dillon Teakell on 12/5/24.
//

import SwiftUI

struct GitHubUserView: View {
    @Binding var user: GitHubUser?
    @Environment(\.dismiss) private var dismiss
    
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
                Text(user?.name ?? "No name provided")
                    .font(.title)
                    .fontWeight(.semibold)
                
                // Follow Metrics
                GitHubFollowMetricsView(user: $user)
                
                // Bio
                Text(user?.bio ?? "No bio provided")
                    .padding()
                
                Divider()
                    .padding(.bottom)
                
                HStack {
                    
                    Image(systemName: "safari")
                        .foregroundStyle(.white)
                        
                        
                    Link("Open in GitHub",destination: URL(string: "https://github.com/\(user?.login ?? "")") ?? URL(string: "https://github.com/home")!)
                        .foregroundStyle(.white)
                        
                }
                .frame(width: 170, height: 40)
                .padding(.horizontal)
                .background(Color.purple)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Spacer()
                
                
            }
            .padding(.vertical)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .tint(.purple)
                }
                
                ToolbarItem(placement: .principal) {
                    Button {
                        dismiss()
                    } label: {
                        Capsule()
                            .fill(.ultraThinMaterial)
                            .frame(width: 45, height: 6.0)
                    }
                }
            }
            .navigationTitle(user?.login ?? "User Login")
        }
    }
}


struct GitHubFollowMetricsView: View {
    
    @Binding var user: GitHubUser?
    
    var body: some View {
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
                Text("Following:")
                    .font(.subheadline)
                
                Text("\(user?.following ?? 0)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
            }
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
