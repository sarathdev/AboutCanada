//
//  CanadaModel.swift
//  AboutCanada
//
//  Created by Sarath Sasi on 19/07/20.
//  Copyright © 2020 Sarath Sasi. All rights reserved.
//

import Foundation

// MARK: - CanadaBaseModel
struct Facts: Codable {
    let title: String?
    let rows: [CanadaFacts]?
}

// MARK: - Row

struct CanadaFacts: Codable {
    let title, factDescription: String?
    let imageHref: String?

    enum CodingKeys: String, CodingKey {
        case title
        case factDescription = "description"
        case imageHref
    }
}
