//
//  HTTPService.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 04/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import Foundation

final class HTTPService {
    // MARK: Public methods
    static func getData<T:Decodable>(url: URL, completion: @escaping(Result<T, Error>) -> ()) {
        getDataFromUrl(url: url){ (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let parsingError {
                completion(.failure(parsingError))
            }
        }
    }
}

// MARK: Private methods
private extension HTTPService {
    static func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            completion(data, response, error)
        }
        task.resume()
    }
}
