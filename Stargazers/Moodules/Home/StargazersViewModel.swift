//
//  StargazersViewModel.swift
//  Stargazers
//
//  Created by MacOS on 11/1/20.
//

import Foundation
import Combine
import UIKit

final class StargazersViewModel: ObservableObject {
 
    @Published private(set) var stargazers: [Stargazer] = []
    
    private var subscription: Cancellable? = nil
    
    private let githubService: GitHubServiceProtocol
    private let imageService: ImageServiceProtocol
    
    init(githubService: GitHubServiceProtocol,
         imageService: ImageServiceProtocol) {
        
        self.githubService = githubService
        self.imageService = imageService
    }
    
    func getStargazers(owner: String, repository: String) {
                    
        subscription = githubService.getStargazersForRepositoryOwner(repository: repository, owner: owner)
            .sink( receiveCompletion: { [weak self] completion in
                
                switch completion {
                case .finished: break
                case .failure: break
                    // Error
                }
            }, receiveValue: { [weak self] (stargazers) in
                
                self?.parseData(data: stargazers)
            })
    }
    
    private func parseData(data: [StargazerData]){
        
        for stargazer in data {
            
            let stargazer = Stargazer(name: stargazer.login,
                                      image: #imageLiteral(resourceName: "avatar-placeholder"),
                                      isLoadingImage: false)
            
            stargazers.append(stargazer)
        }
    }
    
    deinit {
        
        subscription?.cancel()
    }
}
