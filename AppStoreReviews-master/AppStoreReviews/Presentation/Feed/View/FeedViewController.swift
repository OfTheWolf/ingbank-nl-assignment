//
//  AppDelegate.swift
//  AppStoreReviews
//
//  Created by Dmitrii Ivanov on 21/07/2020.
//  Copyright © 2020 ING. All rights reserved.
//

import UIKit
import Extensions

class FeedViewController: UITableViewController {
    
    weak var delegate: FeedViewControllerDelegate?
    
    /// View model object
    var viewModel: FeedViewModel!
    
    /// View model items
    private var items: [ReviewCellModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(for: ReviewCell.self)
        tableView.rowHeight = 160
        
        assert(viewModel != nil, "view model can not be nil")
        
        viewModel.reviewsState.observe(on: self) { [weak self] (state) in
            self?.handleReviewResponse(for: state)
        }
        
        viewModel.topThreeWordsState.observe(on: self) { [weak self] (state) in
            self?.handleTopThreeResponse(for: state)
        }
        
        viewModel.loadReviews(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterAction(_:)))
    }
    
    @objc
    private func filterAction(_ sender: Any){
        showFilterSheet()
    }
    
    private func showFilterSheet(){
        let alert = UIAlertController(title: "Filter Reviews", message: nil, preferredStyle: .actionSheet)
       
        alert.addAction(UIAlertAction(title: "Show All", style: .default, handler: { [unowned self] (alert) in
            self.viewModel.applyFilter(for: .none)
        }))
        
        (1...5).forEach {
            let action = UIAlertAction(title: String(repeating: "⭐️", count: $0), style: .default) { [unowned self] (action) in
                if let index = alert.actions.firstIndex(of: action){
                    self.viewModel.applyFilter(for: .rating(value: index))
                }
            }
            alert.addAction(action)
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /// Handle reviews response from data state
    private func handleReviewResponse(for state: DataState<[ReviewCellModel]>){
        switch state {
        case .loading:
            showLoading()
        case .content(let data):
            hideLoading()
            items = data
            tableView.reloadData()
        case .error(let msg):
            hideLoading()
            showError(with: msg)
        }
    }
    
    /// Handle top three frequent words response from data state
    /// loading and error case omitted here
    private func handleTopThreeResponse(for state: DataState<[String]>){
        switch state {
        case .content(let words):
            showAlert("Top 3 frequent words", words.joined(separator: "\n"))
        default:
            break
        }
    }
    
    // MARK: - UITableViewDataSource and UITableViewDelegate

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = (item as CellConfigurable).dequeueCell(tableView: tableView, at: indexPath) as! ReviewCell
        cell.configure(with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectItem(items[indexPath.row])
    }
}

