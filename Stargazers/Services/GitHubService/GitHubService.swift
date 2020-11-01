//
//  GitHubService.swift
//  Stargazers
//
//  Created by MacOS on 10/31/20.
//

import Foundation
import Combine

class GitHubService: GitHubServiceProtocol {
    
    // HTTP Service Class for make HTTP requests
    private var httpService: HTTPServiceProtocol
    
    init(httpService: HTTPServiceProtocol) {
        self.httpService = httpService
    }
    
    func getStargazersForRepositoryOwner(repository: String, owner: String) -> AnyPublisher<[StargazerData], GitHubServiceError> {
        
        var url = GitHunServiceConfig.stargazersEndpoint
        url = url.replacingOccurrences(of: "{owner}", with: owner)
        url = url.replacingOccurrences(of: "{repository}", with: repository)
        
        return httpService.makeHttpRequest(endpoint: url)
            .map { httpRespose in return httpRespose.data }
            .decode(type: [StargazerData].self, decoder: JSONDecoder())
            .mapError({ error in
                
                switch error {
                default:
                    return GitHubServiceError.CannotRetrieveStargazers(error)
                }
            })
            .map{ result in result }
            .eraseToAnyPublisher()
    }
}
