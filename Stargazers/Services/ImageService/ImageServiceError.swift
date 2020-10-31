//
//  ImageServiceError.swift
//  Stargazers
//
//  Created by MacOS on 10/31/20.
//

import Foundation

enum ImageServiceError: Error {

    case ImageRequestError(Error)
    case ImageNotAvailable
}
