//
//  GitHubServiceProtocol.swift
//  Stargazers
//
//  Created by MacOS on 10/31/20.
//

import Foundation
import Combine

protocol GitHubServiceProtocol {
    
    /// It returns the Stargazers for the repository/owner passed
    func getStargazersForRepositoryOwner(repository: String, owner: String) -> AnyPublisher<[Stargazer], GitHubServiceError>
}
