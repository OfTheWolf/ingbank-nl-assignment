//
//  TopK.swift
//  
//
//  Created by ugur on 30.10.2020.
//

import Foundation

public enum TopK<Element>{
    
    public class Request {
        public init(k: Int, items: [Element]) {
            self.k = k
            self.items = items
        }
        
        public let k: Int
        public let items: [Element]
    }
    
    public struct Response {
        public init(items: [Element]) {
            self.items = items
        }
        
        public let items: [Element]
    }
}

public enum TopKError: Error {
    case empty
}
