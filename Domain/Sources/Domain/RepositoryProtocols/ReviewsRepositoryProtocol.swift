//
//  ReviewsRepositoryProtocol.swift
//  
//
//  Created by ugur on 26.10.2020.
//

import Foundation
import Entities

public protocol ReviewsRepositoryProtocol {
    /// get all reviews
    func getAll(request: Reviews.Request, completion: @escaping (Result<Reviews.Response, Error>) -> Void)
    
    /// Cancel network requests
    func cancel()
}
