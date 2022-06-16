//
//  ViewState.swift
//  App
//
//  Created by uğur on 26.09.2020.
//  Copyright © 2020 ugur. All rights reserved.
//

import Foundation

/// stateful model for view models to handle loading, data and error response
enum DataState<T>{
    
    ///first page loading started
    case loading

    /// successful data result
    case content(_ data: T)
    
    /// data fetch failure with some error message
    case error(_ message: String)
    
    /// true if currently in loading state
    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }
}
