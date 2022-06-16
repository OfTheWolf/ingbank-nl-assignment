//
//  Configurable.swift
//  App
//
//  Created by self on 26.09.2020.
//  Copyright © 2020 ugur. All rights reserved.
//

import Foundation

/// provide cells with view related data
protocol Configurable {
    associatedtype Item
    
    /// Implement this for every cell that needs data
    /// - Parameter item: View model item for othe cell
    func configure(with item: Item)
}
