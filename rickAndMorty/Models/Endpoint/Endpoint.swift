//
//  Endpoint.swift
//  Endpoint
//
//  Created by Arseni Khatsuk on 05.01.2025.
//

import Foundation

enum RickAndMortyEndpoint {
    case character
    case location
    case episode
    
    var baseURL: URL {
        guard let url = URL(string: API.baseURL) else {
            fatalError("Invalid base URL")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .character:
            return "character"
        case .location:
            return "location"
        case .episode:
            return "episode"
        }
    }
    
    var method: String {
        return "GET"
    }
    
    var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }

    func makeURLRequest(queryItems: [URLQueryItem] = []) -> URLRequest? {
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else { return nil }
        components.path += path
        components.queryItems = queryItems.isEmpty ? nil : queryItems
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        return request
    }
}

enum HTTPClientError: Error {
    case invalidURL
    case invalidResponse(statusCode: Int?, data: Data?)
    case noData
}
