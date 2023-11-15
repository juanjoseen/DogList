//
//  Api.swift
//  DogList
//
//  Created by Juan Jose Elias Navaro on 15/11/23.
//

import Foundation

class Api {
    private let baseURL: String = "https://jsonblob.com/api/1151549092634943488"
    
    private init() {}
    
    public static let shared: Api = Api()
    
    public func getDogList(completion: @escaping (Result<[Dog], ApiError>) -> Void) {
        guard let url: URL = URL(string: baseURL) else {
            completion(.failure(.badURL))
            return
        }
        let request: URLRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                completion(.failure(.text(error!.localizedDescription)))
                return
            }
            if let data = data {
                do {
                    let response: [Dog] = try JSONDecoder().decode([Dog].self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.text(error.localizedDescription)))
                }
            } else {
                completion(.failure(.noData))
            }
        }.resume()
    }
}

enum ApiError: Error {
    case badURL
    case noData
    case badDecoding
    case text(String)
    
    var localizedDescription: String {
        switch self {
        case .badURL:
            return "The URL isn't valid"
        case .noData:
            return "No data returned"
        case .badDecoding:
            return "Error while decoding objects"
        case .text(let string):
            return string
        }
    }
}
