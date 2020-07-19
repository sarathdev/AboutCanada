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
    
    public func fetchCanadaFacts(withCompletion completion: @escaping (Result<BaseModel, NetworkError>) -> Void) {
        guard let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts") else {
            completion(.failure(.badURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.apiError))
                return
            }
            do {
                // make sure this JSON is in the format we expect
                let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8)
                let data = try JSONDecoder().decode(BaseModel.self, from: utf8Data!)
                
                completion(.success(data))
            } catch {
                completion(.failure(.jsonParsingError))
            }
        }
        task.resume()
    }
    
    //URL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    private struct Constants {
        static let baseURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/"
        static let facts = "facts.json"
    }
}
enum NetworkError: Error {
     case badURL
     case jsonParsingError
     case apiError
 }
