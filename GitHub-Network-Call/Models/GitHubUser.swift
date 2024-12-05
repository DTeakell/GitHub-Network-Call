//
//  GitHubUser.swift
//  GitHub-Network-Call
//
//  Created by Dillon Teakell on 12/4/24.
//

import Foundation

struct GitHubUser: Decodable {
    let login: String?
    let name: String?
    let avatarUrl: URL?
    let url: URL?
    let bio: String?
    let followers: Int?
    let following: Int?
}
