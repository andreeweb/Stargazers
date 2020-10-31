//
//  GitHubServiceError.swift
//  Stargazers
//
//  Created by MacOS on 10/31/20.
//

import Foundation

enum GitHubServiceError: Error {
    
    case CannotRetrieveStargazers(Error)
}
