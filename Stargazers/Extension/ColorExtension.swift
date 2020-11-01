//
//  ColorExtension.swift
//  Stargazers
//
//  Created by MacOS on 11/1/20.
//

import SwiftUI

extension Color {
    
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
