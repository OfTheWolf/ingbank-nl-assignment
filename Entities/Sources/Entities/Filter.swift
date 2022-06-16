//
//  Filter.swift
//  
//
//  Created by ugur on 30.10.2020.
//

import Foundation

public enum Filter<Element>{
    
    public class Request {
        public init(type: FilterType, items: [Element]) {
            self.type = type
            self.items = items
        }
        
        public let type: FilterType
        public let items: [Element]
    }
    
    public struct Response {
        public init(items: [Element]) {
            self.items = items
        }
        
        public let items: [Element]
    }
}
