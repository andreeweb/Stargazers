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
    private var imageSubscriptions: [Cancellable] = []
    
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
        
        for stargazerData in data {
            
            let stargazer = Stargazer(name: stargazerData.login,
                                      image: #imageLiteral(resourceName: "avatar-placeholder"),
                                      isLoadingImage: false)
            
            stargazers.append(stargazer)
            
            // async download image
            downloadImage(for: stargazerData)
        }
    }
    
    private func downloadImage(for stargazer: StargazerData){
        
        let sub = imageService.getImageFromUrl(url: stargazer.avatar_url).sink(
            receiveCompletion: { [weak self] completion in
                
                switch completion {
                case .finished:
                    break
                case .failure:
                    self?.updateStargazerWithImage(image: nil, stargazer: stargazer)
                }
                
            }, receiveValue: { [weak self] (image) in
                
                self?.updateStargazerWithImage(image: image, stargazer: stargazer)
        })
        
        imageSubscriptions.append(sub)
    }
    
    private func updateStargazerWithImage(image: UIImage?,
                                          stargazer: StargazerData) {
        
        var backgroundImage = #imageLiteral(resourceName: "avatar-placeholder")
        
        if image != nil {
            backgroundImage = image!
        }
        
        let stargazer = Stargazer(name: stargazer.login,
                                  image: backgroundImage,
                                  isLoadingImage: false)
        
        stargazers.append(stargazer)
        
        if let i = stargazers.firstIndex(where: { $0.name == stargazer.name }) {
            stargazers[i] = stargazer
        }
    }
    
    deinit {
        
        subscription?.cancel()
    }
}
