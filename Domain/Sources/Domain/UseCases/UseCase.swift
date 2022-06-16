//
//  UseCase.swift
//  
//
//  Created by ugur on 26.10.2020.
//

import Foundation

public protocol UseCase {
    associatedtype Request
    associatedtype Response

    func execute(_ request: Request, completion: @escaping (Result<Response, Error>) -> Void)
    
    func cancel()
}
