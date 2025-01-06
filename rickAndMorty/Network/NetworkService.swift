//
//  NetworkService.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 05.01.2025.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    func fetch(endpoint: API, completion: @escaping(Result<Data, Error>) -> Void) {
        let url = endpoint.url
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
                let statusError = NSError(
                    domain: "NetworkService",
                    code:  (response as? HTTPURLResponse)?.statusCode ?? -1,
                    userInfo: [NSLocalizedDescriptionKey: "Invalid status code"]
                )
                completion(.failure(statusError))
                return
            }
            guard let data = data else {
                let dataError = NSError(
                    domain: "NetworkService",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "Invalid data"]
                )
                completion(.failure(dataError))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
