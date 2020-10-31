//
//  ImageService.swift
//  Stargazers
//
//  Created by MacOS on 10/31/20.
//

import Foundation
import Combine
import UIKit

class ImageService: ImageServiceProtocol {
    
    // HTTP Service Class for make HTTP requests
    private var httpService: HTTPServiceProtocol
    
    init(httpService: HTTPServiceProtocol) {
        self.httpService = httpService
    }
    
    func getImageFromUrl(url: String) -> AnyPublisher<UIImage, ImageServiceError> {
                
        return httpService.makeHttpRequest(endpoint: url)
            .mapError { error in return ImageServiceError.ImageRequestError(error) }
            .tryMap { httpRespose in

                if let image = UIImage(data: httpRespose.data) {
                    return image
                }else{
                    throw ImageServiceError.ImageNotAvailable
                }
            }
            .mapError { error in return error as! ImageServiceError }
            .eraseToAnyPublisher()
    }
}
