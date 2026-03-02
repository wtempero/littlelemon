//
//  MenuItem.swift
//  littlelemon
//
//  Created by William Tempero on 3/1/26.
//

import Foundation

struct MenuItem: Decodable, Identifiable {
    let id: Int
    let title: String
    let image: String
    let price: String
    let description: String?
    let category: String?
}

