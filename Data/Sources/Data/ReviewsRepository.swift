//
//  ReviewsRepository.swift
//  
//
//  Created by ugur on 26.10.2020.
//

import Foundation
import Domain
import Entities
import Services
import Networking

public class ReviewsRepository: ReviewsRepositoryProtocol{
    
    public init() {}
    
    var getAllTask: ApiCancellable?
    
    public func getAll(request: Reviews.Request,
                       completion: @escaping (Result<Reviews.Response, Error>) -> Void) {
        getAllTask = ApiRequest(resource: ReviewsResource()).load(withCompletion: completion)
    }
    
    public func cancel(){
        getAllTask?.cancelTask()
    }
    
}
