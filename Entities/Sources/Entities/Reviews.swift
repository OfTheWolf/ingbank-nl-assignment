//
//  Reviews.swift
//  
//
//  Created by ugur on 26.10.2020.
//

import Foundation

public enum Reviews {
    public struct Request: Codable {
        public init(){}
        
    }
    
    public struct Response: Codable {
        public let feed: Feed?
    }
}
