//
//  ApiResource.swift
//  
//
//  Created by ugur on 26.10.2020.
//

import Foundation

public protocol ApiResource {
    associatedtype ModelType: Decodable
    var methodPath: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String]? { get }
    var defaultHeaders: [String: String]? { get }
    var queryItems: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var baseUrl: String { get }
}

public extension ApiResource{
    var defaultHeaders: [String : String]?{
        return nil
    }
}

extension ApiResource {
    var urlRequest: URLRequest {
        var components = URLComponents(string: baseUrl)!
        components.path = methodPath

        components.queryItems = queryItems?.compactMap({ (arg0) -> URLQueryItem? in
            let (key, value) = arg0
            return URLQueryItem(name: key, value: value)
        })
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = httpMethod.rawValue
        
        if let params = parameters{
            let jsonData = try? JSONSerialization.data(withJSONObject: params)
            request.httpBody = jsonData
        }
        
        headers?.forEach({ (arg0) in
            let (key, value) = arg0
            request.addValue(value, forHTTPHeaderField: key)
        })
        defaultHeaders?.forEach({ (arg0) in
            let (key, value) = arg0
            request.addValue(value, forHTTPHeaderField: key)
        })
        return request
    }
}
