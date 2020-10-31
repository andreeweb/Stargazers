//
//  HTTPServiceMock.swift
//  StargazersTests
//
//  Created by MacOS on 10/31/20.
//

import Foundation
import Combine

class HTTPServiceMock: HTTPServiceProtocol {
    
    var validJson: Bool = true
    var validHTTPConnection: Bool = true
            
    func makeHttpRequest(endpoint: String) -> AnyPublisher<HTTPServiceResponse, HTTPServiceError> {
            
        guard URL(string: endpoint) != nil else {
            return Fail(error: HTTPServiceError.HTTPEndpointNotValid).eraseToAnyPublisher()
        }
        
        if !validHTTPConnection {
            return Fail(error: HTTPServiceError.HTTPRequestError(reason: "Mock error")).eraseToAnyPublisher()
        }
        
        var resultData = """
        [
          {
            "login": "baiyunping333",
            "id": 4901397,
            "node_id": "MDQ6VXNlcjQ5MDEzOTc=",
            "avatar_url": "https://avatars0.githubusercontent.com/u/4901397?v=4",
            "gravatar_id": "",
            "url": "https://api.github.com/users/baiyunping333",
            "html_url": "https://github.com/baiyunping333",
            "followers_url": "https://api.github.com/users/baiyunping333/followers",
            "following_url": "https://api.github.com/users/baiyunping333/following{/other_user}",
            "gists_url": "https://api.github.com/users/baiyunping333/gists{/gist_id}",
            "starred_url": "https://api.github.com/users/baiyunping333/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/baiyunping333/subscriptions",
            "organizations_url": "https://api.github.com/users/baiyunping333/orgs",
            "repos_url": "https://api.github.com/users/baiyunping333/repos",
            "events_url": "https://api.github.com/users/baiyunping333/events{/privacy}",
            "received_events_url": "https://api.github.com/users/baiyunping333/received_events",
            "type": "User",
            "site_admin": false
          }
        ]
        """.data(using: .utf8)
        
        if !validJson {
            resultData = "{]".data(using: .utf8)
        }
    
        return Just(HTTPServiceResponse(data: resultData!))
            .setFailureType(to: HTTPServiceError.self)
            .eraseToAnyPublisher()
    }
}