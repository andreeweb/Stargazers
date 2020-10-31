//
//  HTTPServiceProtocol.swift
//  Stargazers
//
//  Created by MacOS on 10/31/20.
//

import Foundation
import Combine

protocol HTTPServiceProtocol {
    
    /// This function makes HTTP request to the endpoint passed and returns
    /// results wrapped into HTTPServiceResponse object. If an error occurs
    /// this function returns a HTTPServiceError.
    ///
    /// - Parameter endpoint: request endpoint
    /// - Returns: AnyPublisher<HTTPServiceResponse, HTTPServiceError>
    func makeHttpRequest(endpoint: String) -> AnyPublisher<HTTPServiceResponse, HTTPServiceError>
}
