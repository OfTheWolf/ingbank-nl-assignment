//
//  ReviewsResource.swift
//  
//
//  Created by ugur on 26.10.2020.
//

import Foundation
import Entities
import Networking

public struct ReviewsResource: ApiResource {
    let id: String
    let sortBy: String

    public init(id: String = "474495017", sortBy: String = "mostrecent") {
        self.id = id
        self.sortBy = sortBy
    }
    
    public typealias ModelType = Reviews.Response

    public var headers: [String : String]?

    public var queryItems: [String : String]?

    public var httpMethod: HTTPMethod  = .get
    
    public var parameters: [String : Any]? = nil
    
    public var methodPath: String {
        "/nl/rss/customerreviews/id=\(id)/sortby=\(sortBy)/json"
    }
    
    public var baseUrl: String = "https://itunes.apple.com"
    
}
