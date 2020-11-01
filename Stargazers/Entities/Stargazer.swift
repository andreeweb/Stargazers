//
//  Stargazer.swift
//  Stargazers
//
//  Created by MacOS on 11/1/20.
//

import Foundation
import UIKit

struct Stargazer: Identifiable {
    
    var id = UUID()
    let repositoryName: String
    let repositoryOwner: String
    let image: UIImage
    var isLoadingImage: Bool
}
