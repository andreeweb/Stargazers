//
//  HTTPServiceError.swift
//  Stargazers
//
//  Created by MacOS on 10/31/20.
//

import Foundation

enum HTTPServiceError: Error {
    case HTTPRequestError(reason: String)
    case HTTPResponseError
    case HTTPEndpointNotValid
    case HTTPError(statusCode: Int)
}
