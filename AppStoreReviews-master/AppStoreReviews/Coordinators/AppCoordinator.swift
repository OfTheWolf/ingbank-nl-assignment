//
//  AppCoordinator.swift
//  AppStoreReviews
//
//  Created by ugur on 28.10.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import UIKit
import Domain
import Data

protocol FeedViewControllerDelegate: class {
    func didSelectItem(_ item: ReviewCellModel)
}

class AppCoordinator: Coordinator, FeedViewControllerDelegate {
    
    let window: UIWindow
    let rootViewController: UINavigationController

    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
    }
    
    func start() {
        let searchVC = FeedViewController()
        searchVC.delegate = self
        searchVC.title = "Reviews"
        searchVC.viewModel = DefaultFeedViewModel(reviewsUseCase: ReviewsUseCase(repo: ReviewsRepository()),
                                                  filterReviewsUseCase: FilterReviewsUseCase(),
                                                  topKWordsUseCase: TopKWordsUseCase())
        rootViewController.pushViewController(searchVC, animated: true)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    // MARK: - FeedViewControllerDelegate
    
    func didSelectItem(_ item: ReviewCellModel) {
        let detailVC = DetailsViewController(review: item)
        rootViewController.pushViewController(detailVC, animated: true)
    }
}
