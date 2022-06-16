//
//  CellConfigurable.swift
//  App
//
//  Created by uğur on 23.09.2020.
//  Copyright © 2020 ugur. All rights reserved.
//

import UIKit

/// Implement this for all view model items which corresponds foreach table view cell
protocol CellConfigurable {
    
    /// Provide model to the cell
    /// - Parameter cell: corresponding table view cell
    func configure(cell: UITableViewCell)
    
    /// Get reusable table view cell
    /// - Parameters:
    ///   - tableView: current table view
    ///   - indexPath: current index path
    func dequeueCell(tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    
}
