//
//  NetworkRequest.swift
//  
//
//  Created by ugur on 26.10.2020.
//

import Foundation

public protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) throws -> ModelType
    func load(withCompletion completion: @escaping (Result<ModelType, Error>) -> Void) -> ApiCancellable
}

public extension NetworkRequest {
    func load(_ urlRequest: URLRequest, withCompletion completion: @escaping (Result<ModelType, Error>) -> Void) -> ApiCancellable{
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard error == nil else {
                completion(.failure(ApiError.custom(error!.localizedDescription)))
                return
            }
                        guard let data = data else {
                completion(.failure(ApiError.noData))
                return
            }
            
            do{
                completion(.success(try self.decode(data)))
            }catch let error{
                completion(.failure(ApiError.custom(error.localizedDescription)))
            }
        })
        task.resume()
        return task
    }
}
