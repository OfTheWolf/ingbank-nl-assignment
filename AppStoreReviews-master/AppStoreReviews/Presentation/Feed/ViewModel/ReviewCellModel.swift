//
//  AppDelegate.swift
//  AppStoreReviews
//
//  Created by Dmitrii Ivanov on 21/07/2020.
//  Copyright © 2020 ING. All rights reserved.
//

import UIKit
import Entities

// MARK: - ReviewCellModel
struct ReviewCellModel {
    let author: String
    let version: String
    let rating: Int
    let title: String
    let id: String
    let content: String
    
    func ratingVersionText() -> String {
        let stars = String(repeating: "⭐️", count: rating)
        return "\(stars) (ver: \(version))"
    }
    
    static func mapFrom(entries: [Entry]) -> [ReviewCellModel]{
        entries.compactMap{
            ReviewCellModel(author: $0.author?.name?.label ?? "",
                   version: $0.imVersion?.label ?? "",
                   rating: $0.ratingAsInt(),
                   title: $0.title?.label ?? "",
                   id: $0.id?.label ?? "",
                   content: $0.content?.label ?? "")
        }
    }
}

// MARK: - CellConfigurable
extension ReviewCellModel: CellConfigurable{
    func configure(cell: UITableViewCell) {
        (cell as! ReviewCell).configure(with: self)
    }
    
    func dequeueCell(tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueCell(for: ReviewCell.self, at: indexPath)
    }
}
