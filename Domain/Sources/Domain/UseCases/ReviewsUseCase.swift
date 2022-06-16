//
//  ReviewsUseCase.swift
//  
//
//  Created by ugur on 26.10.2020.
//

import Foundation
import Entities

public final class ReviewsUseCase: UseCase {
    
    public typealias Request = Reviews.Request
    public typealias Response = Reviews.Response
    
    let repo: ReviewsRepositoryProtocol
    
    public init(repo: ReviewsRepositoryProtocol){
        self.repo = repo
    }
    
    public func execute(_ request: Request, completion: @escaping (Result<Response, Error>) -> Void) {
        repo.getAll(request: request, completion: completion)
    }
    
    public func cancel() {
        repo.cancel()
    }
}
