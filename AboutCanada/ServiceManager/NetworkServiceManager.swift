//
//  NetworkServiceManager.swift
//  AboutCanada
//
//  Created by Sarath Sasi on 19/07/20.
//  Copyright © 2020 Sarath Sasi. All rights reserved.
//

import Foundation

final class NetworkServiceManager{
    static let sharedInstance = NetworkServiceManager()
    private init() {}

}
//URL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
private struct Constants {
    static let baseURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/"
    static let facts = "facts.json"
}

enum NetworkError: Error {
    case badURL
    case jsonParsingError
    case apiError
}
