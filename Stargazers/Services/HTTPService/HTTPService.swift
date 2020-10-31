//
//  HTTPService.swift
//  Stargazers
//
//  Created by MacOS on 10/31/20.
//

import Foundation
import Combine

class HTTPService: HTTPServiceProtocol {
    
    func makeHttpRequest(endpoint: String) -> AnyPublisher<HTTPServiceResponse, HTTPServiceError> {
        
        guard let url = URL(string: endpoint) else {
            return Fail(error: HTTPServiceError.HTTPEndpointNotValid).eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { data, response in
                                                
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw HTTPServiceError.HTTPResponseError
                }
                
                guard httpResponse.statusCode == 200 else {
                    throw HTTPServiceError.HTTPError(statusCode: httpResponse.statusCode)
                }
                
                let httpResponseResult = HTTPServiceResponse(data: data)
                return httpResponseResult
            }
            .mapError { error in
                
                return HTTPServiceError.HTTPRequestError(reason: error.localizedDescription)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
