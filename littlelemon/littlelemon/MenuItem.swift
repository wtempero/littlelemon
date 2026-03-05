//
//  MenuItem.swift
//  littlelemon
//
//  Created by William Tempero on 3/1/26.
//

import Foundation

nonisolated struct MenuItem: Decodable, Identifiable {
    // nonilsolated suppresses compiler warning...
    // Main actor-isolated conformance of 'MenuItem' to 'Decodable' cannot be used in nonisolated context
    // This type has no actor isolation requirements, no mutable data, therefore...
    // It is safe to decode, copy, send across threads, or use from any context.

    // everything is optional so we don't crash on bad/nil data fetch
    let id: Int?
    let title: String?
    let image: String?
    let price: String?
    let description: String?
    let category: String?

    enum CodingKeys: String, CodingKey
    {
        case id
        case title
        case price
        case image
        case category
        case description = "description"   // maps JSON "description" to Swift "description"...
        // This is necessary because Dish data model cannot take Swift Core Data reserved keyword "description"
    }
}

