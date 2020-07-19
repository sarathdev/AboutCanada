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
    
    ///
    // MARK: - Private functions
       private static func getData(url: URL,
                                   completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
           URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
       }
       
       // MARK: - Public function
       
       /// downloadImage function will download the thumbnail images
       /// returns Result<Data> as completion handler
       public static func downloadImage(url: URL,
                                        completion: @escaping (Results<Data>) -> Void) {
           NetworkServiceManager.getData(url: url) { data, response, error in
               
               if let error = error {
                   completion(.failure(error))
                   return
               }
               
               guard let data = data, error == nil else {
                   return
               }
               
               DispatchQueue.main.async() {
                   completion(.success(data))
               }
           }
       }
    

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
/// Result enum is a generic for any type of value
/// with success and failure case
public enum Results<T> {
    case success(T)
    case failure(Error)
}
