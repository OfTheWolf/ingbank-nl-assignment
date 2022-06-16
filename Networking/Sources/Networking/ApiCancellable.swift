//
//  ApiCancellable.swift
//  
//
//  Created by ugur on 26.10.2020.
//

import Foundation

public protocol ApiCancellable{
    func cancelTask()
}

extension URLSessionDataTask: ApiCancellable{
    public func cancelTask() {
        cancel()
    }
}
