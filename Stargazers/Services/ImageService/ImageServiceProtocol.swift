//
//  ImageServiceProtocol.swift
//  Stargazers
//
//  Created by MacOS on 10/31/20.
//

import Foundation
import Combine
import UIKit

protocol ImageServiceProtocol {
    
    func getImageFromUrl(url: String) -> AnyPublisher<UIImage, ImageServiceError>
}
