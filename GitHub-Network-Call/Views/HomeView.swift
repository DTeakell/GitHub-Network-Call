//
//  HomeView.swift
//  GitHub-Network-Call
//
//  Created by Dillon Teakell on 12/4/24.
//

import SwiftUI

struct HomeView: View {
    
    // GitHub user and user manager properties
    @State private var user: GitHubUser?
    @State private var userName: String = ""
    let userManager = GitHubUserManager()
    
    // Alert properties
    @State private var isShowingAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    // Sheet property
    @State private var isShowingGitHubUserView: Bool = false
    
    @MainActor
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                
                Text("Enter GitHub username to get user information!")
                    .padding()
                
                VStack (alignment: .center) {
                    TextField("Enter GitHub Username", text: $userName)
                        .padding(10)
                        .background(Color(uiColor: .systemGray6))
                        .keyboardType(.default)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)
                        .padding(.bottom, 5)
                    
                    
                    Button ("Get User") {
                        Task {
                            do {
                                user = try await userManager.getUser(userName: userName)
                                isShowingGitHubUserView.toggle()
                            } catch GitHubUserManagerError.invalidURL {
                                isShowingAlert.toggle()
                                alertTitle = "Invalid URL"
                                alertMessage = "The URL is invalid. Please confirm the URL is correct."
                            }
                            catch GitHubUserManagerError.invalidData {
                                isShowingAlert.toggle()
                                alertTitle = "Invalid Data"
                                alertMessage = "The data returned from the server is invalid. Please confirm the URL is correct."
                            }
                            catch GitHubUserManagerError.badRequest {
                                isShowingAlert.toggle()
                                alertTitle = "Bad Request"
                                alertMessage = "The server returned a bad request. Please confirm the URL is correct."
                            }
                            catch GitHubUserManagerError.unauthorized {
                                isShowingAlert.toggle()
                                alertTitle = "Unauthorized"
                                alertMessage = "You are unauthorized to access this resource."
                            }
                            catch GitHubUserManagerError.forbidden {
                                isShowingAlert.toggle()
                                alertTitle = "Forbidden"
                                alertMessage = "You are forbidden to access this resource."
                            }
                            catch GitHubUserManagerError.notFound {
                                isShowingAlert.toggle()
                                alertTitle = "Server Not Found"
                                alertMessage = "The server could not be found. Please confirm the URL is correct."
                            }
                            catch GitHubUserManagerError.requestTimeout {
                                isShowingAlert.toggle()
                                alertTitle = "Request Timeout"
                                alertMessage = "The server timed out waiting for a response. Please check your internet connection, confirm the URL is correct, and try again."
                            }
                            catch GitHubUserManagerError.internalServerError {
                                isShowingAlert.toggle()
                                alertTitle = "Internal Server Error"
                                alertMessage = "The server encountered an internal error. Please try again later."
                            }
                            catch GitHubUserManagerError.badGateway {
                                isShowingAlert.toggle()
                                alertTitle = "Bad Gateway"
                                alertMessage = "The server received a bad gateway response. Please try again later."
                            }
                            catch GitHubUserManagerError.serviceUnavailable {
                                isShowingAlert.toggle()
                                alertTitle = "Service Unavailable"
                                alertMessage = "The server is currently unavailable. Please try again later."
                            }
                            catch GitHubUserManagerError.unknown {
                                isShowingAlert.toggle()
                                alertTitle = "Unknown Error"
                                alertMessage = "An unknown error occurred. Please try again later."
                            }
                            catch {
                                isShowingAlert.toggle()
                                alertTitle = "Unknown Error"
                                alertMessage = "An unknown error has occured. Please try again later."
                            }
                        }
                    }
                    .padding(.vertical, 10)
                    .buttonStyle(.borderedProminent)
                    .disabled(userName.isEmpty)
                }
            }
            
            .tint(.purple)
            .alert(isPresented: $isShowingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage))
            }
            .sheet(isPresented: $isShowingGitHubUserView) {
                GitHubUserView(user: $user)
            }
            .navigationTitle("GitHub Search")
            
            Spacer()
        }
    }
}


#Preview {
    HomeView()
}
