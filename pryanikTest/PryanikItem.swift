//
//  PryanikItem.swift
//  pryanikTest
//
//  Created by Олег Бабыр on 06.06.2021.
//

import Foundation

struct PryanikData: Codable {
    let name: String
    let data: PryanikItem
}

struct PryanikItem: Codable {
    let text: String?
    let url: URL?
    var selectedID: Int?
    let variants: [Variant]?

    enum CodingKeys: String, CodingKey {
        case text, url
        case selectedID = "selectedId"
        case variants
    }
}

struct Variant: Codable {
    let id: Int
    let text: String
}
