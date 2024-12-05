//
//  GitHubUserManager.swift
//  GitHub-Network-Call
//
//  Created by Dillon Teakell on 12/4/24.
//

import Foundation

enum GitHubUserManagerError: Error {
    case invalidURL
    case invalidData
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case requestTimeout
    case internalServerError
    case badGateway
    case serviceUnavailable
    case unknown
}

class GitHubUserManager {
    
    // API Call
    func getUser(userName: String) async throws -> GitHubUser {
        // Get endpoint
        let endpoint = "https://api.github.com/users/\(userName)"
        
        // Convert enpoint string to URL and catch any errors if the URL is incorrect
        guard let url = URL(string: endpoint) else {
            throw GitHubUserManagerError.invalidURL
        }
        
        // Get data and status code from URL
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Make the response code into an HTTPURLResonse code
        guard let response = response as? HTTPURLResponse else {
            throw GitHubUserManagerError.unknown
        }
        
        // Handle the reponse codes
        switch response.statusCode {
        // Successful response
        case 200:
            print("Response \(response.statusCode): Successful")
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(GitHubUser.self, from: data)
            } catch {
                throw GitHubUserManagerError.invalidData
            }
        case 400:
            throw GitHubUserManagerError.badRequest
        case 401:
            throw GitHubUserManagerError.unauthorized
        case 403:
            throw GitHubUserManagerError.forbidden
        case 404:
            throw GitHubUserManagerError.notFound
        case 408:
            throw GitHubUserManagerError.requestTimeout
        case 500:
            throw GitHubUserManagerError.internalServerError
        case 502:
            throw GitHubUserManagerError.badGateway
        case 503:
            throw GitHubUserManagerError.serviceUnavailable
        default:
            throw GitHubUserManagerError.unknown
        }
    }
}
