//
//  ApiError.swift
//  
//
//  Created by ugur on 27.10.2020.
//

import Foundation

public enum ApiError: Error{
    case noData
    case custom(String)
}
