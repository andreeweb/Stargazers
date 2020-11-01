//
//  StargazersApp.swift
//  Stargazers
//
//  Created by MacOS on 10/31/20.
//

import SwiftUI

@main
struct StargazersApp: App {
    var body: some Scene {
        WindowGroup {
            
            let httpService = HTTPService()
            let githubService = GitHubService(httpService: httpService)
            let imageService = ImageService(httpService: httpService)
            
            let viewModel = StargazersViewModel(githubService: githubService,
                                                imageService: imageService)
            
            StargazersView(viewModel: viewModel)
        }
    }
}
