//
//  Color+App.swift
//  littlelemon
//
//  Created by William Tempero on 3/2/26.
//

import SwiftUI

extension Color {
    // Brand colors from Figma / Assets.xcassets
    static let littleLemonYellow = Color("LlYellow")
    static let primary           = Color("Primary")           // if you have one
    static let accent            = Color("Accent")
    static let textPrimary       = Color("TextPrimary")
    static let background        = Color("Background")
    
    // Semantic / system fallbacks (optional)
    static let textSecondary     = Color.secondary
    static let surface           = Color(.systemBackground)
}
