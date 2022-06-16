//
//  ApiRequest.swift
//  
//
//  Created by ugur on 26.10.2020.
//

import Foundation

public class ApiRequest<Resource: ApiResource> {
    let resource: Resource
    
    public init(resource: Resource) {
        self.resource = resource
    }
}

extension ApiRequest: NetworkRequest {
    
    public func decode(_ data: Data) throws -> Resource.ModelType {
        return try JSONDecoder().decode(Resource.ModelType.self, from: data)
    }

    public func load(withCompletion completion: @escaping (Result<Resource.ModelType, Error>) -> Void) -> ApiCancellable {
        load(resource.urlRequest, withCompletion: completion)
    }
}
