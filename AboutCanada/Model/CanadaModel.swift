//
//  CanadaModel.swift
//  AboutCanada
//
//  Created by Sarath Sasi on 19/07/20.
//  Copyright © 2020 Sarath Sasi. All rights reserved.
//

import Foundation

// MARK: - CanadaBaseModel

struct BaseModel: Codable {
    let title: String?
    let rows: [Row]?
}

// MARK: - Row

struct Row: Codable {
    let title, rowDescription: String?
    let imageHref: String?

    enum CodingKeys: String, CodingKey {
        case title
        case rowDescription = "description"
        case imageHref
    }
}
