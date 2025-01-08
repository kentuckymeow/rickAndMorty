//
//  HTTPClient.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 06.01.2025.
//

import Foundation

typealias HTTPResult = Result<Data, Error>
protocol IHTTPClient {
    func request(target: RickAndMortyEndpoint, completion: @escaping (HTTPResult) -> Void)
}

struct HTTPClient: IHTTPClient {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func request(target: RickAndMortyEndpoint, completion: @escaping (HTTPResult) -> Void) {
        guard let urlRequest = target.makeURLRequest() else {
            completion(.failure(HTTPClientError.invalidURL))
            return
        }

        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(HTTPClientError.invalidResponse(statusCode: nil, data: nil)))
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(HTTPClientError.invalidResponse(statusCode: httpResponse.statusCode, data: data)))
                return
            }

            guard let data = data else {
                completion(.failure(HTTPClientError.noData))
                return
            }

            completion(.success(data))
        }
        task.resume()
    }

}

extension IHTTPClient {
    func retry(_ retryCount: UInt) -> IHTTPClient {
        var service: IHTTPClient = self
        for _ in 0..<retryCount {
            service = service.fallback(self)
        }
        return service
    }

    private func fallback(_ fallback: IHTTPClient) -> IHTTPClient {
        IHTTPServiceWithFallback(primary: self, fallback: fallback)
    }
}

private struct IHTTPServiceWithFallback: IHTTPClient {
    let primary: IHTTPClient
    let fallback: IHTTPClient

    func request(target: RickAndMortyEndpoint, completion: @escaping (HTTPResult) -> Void) {
        primary.request(target: target) { result in
            switch result {
            case .success:
                completion(result)
            case .failure:
                fallback.request(target: target, completion: completion)
            }
        }
    }
}

