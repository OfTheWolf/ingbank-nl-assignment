//
//  FilterReviewsUseCase.swift
//  
//
//  Created by ugur on 30.10.2020.
//

import Foundation
import Entities

public final class FilterReviewsUseCase: UseCase{
    public typealias Request = Filter<Entry>.Request
    public typealias Response = Filter<Entry>.Response

    public init(){}
    
    public func execute(_ request: Request, completion: @escaping (Result<Response, Error>) -> Void) {
        switch request.type {
        case .rating(let value):
            let result = request.items.filter{$0.ratingAsInt() == value}
            completion(.success(Response(items: result)))
        case .none:
            completion(.success(Response(items: request.items)))
        }
    }
    
    public func cancel() {
        
    }
}
