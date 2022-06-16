//
//  FeedViewModel.swift
//  AppStoreReviews
//
//  Created by ugur on 28.10.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import Foundation
import Domain
import Entities

// MARK: - ViewModel Protocols

/// Receive actions from the view
protocol FeedViewModelInput {
    func loadReviews(_ cancelPreviousRequests: Bool)
    func applyFilter(for type: FilterType)
    func showTopThreeFrequentWords()
}

/// Pass results to the ViewController
protocol FeedViewModelOutput {
    ///observable stateful review items
    var reviewsState: Observable<DataState<[ReviewCellModel]>> {get}
    var topThreeWordsState: Observable<DataState<[String]>> {get}
}

/// palceholder view model input and output
typealias FeedViewModel = FeedViewModelInput & FeedViewModelOutput


// MARK: - ViewModel Implementation

/// Default FeedViewModel implementation
final class DefaultFeedViewModel: FeedViewModel {
    
    /// Use case to perform reviews data operations
    private let reviewsUseCase: ReviewsUseCase
    
    /// Filter reviews use case
    private let filterReviewsUseCase: FilterReviewsUseCase
    
    /// Top k frequent words use case
    private let topKWordsUseCase: TopKWordsUseCase
    
    
    /// all reviews
    private var reviews: [Entry] = []

    /// filtered reviews
    private var filteredReviews: [Entry] = []{
        didSet{
            showTopThreeFrequentWords()
        }
    }
    
    /// last selected filter. default is no filter.
    private var currentFilter: FilterType = .none

    /// init with reviews use case
    init(reviewsUseCase: ReviewsUseCase,
         filterReviewsUseCase: FilterReviewsUseCase,
         topKWordsUseCase: TopKWordsUseCase) {
        self.reviewsUseCase = reviewsUseCase
        self.filterReviewsUseCase = filterReviewsUseCase
        self.topKWordsUseCase = topKWordsUseCase
    }
    
    //    MARK: - FeedViewModelInput

    /// load reviews
    /// - Parameter cancelPreviousRequests: Set true to cancel previous use case operation, false otherwise. Default is set to true.
    func loadReviews(_ cancelPreviousRequests: Bool) {
        
        /// cancel previous requests
        if cancelPreviousRequests{
            reviewsUseCase.cancel()
        }
        
        reviewsState.value = .loading

        /// performs fetch from data source
        reviewsUseCase.execute(ReviewsUseCase.Request()) { [weak self] (result) in
            guard let sSelf = self else {return}
            switch result{
            case .success(let model):
                guard let entries = model.feed?.entry else {
                    sSelf.reviewsState.value = .error("No entry found")
                    return
                }
                sSelf.reviews = entries
                sSelf.applyFilter(for: sSelf.currentFilter)
                
            case .failure(let error):
                sSelf.reviewsState.value = .error(error.localizedDescription)
            }
        }
    }
    
    /// Show filtered reviews
    /// - Parameter type: filter type
    func applyFilter(for type: FilterType) {
        let request = FilterReviewsUseCase.Request(type: type, items: reviews)

        filterReviewsUseCase.execute(request) { [weak self] (result) in
            guard let sSelf = self else {return}
        
            switch result{
            case .success(let response):
                sSelf.filteredReviews = response.items
                sSelf.reviewsState.value = .content(ReviewCellModel.mapFrom(entries: response.items))
            case .failure(let error):
                sSelf.reviewsState.value = .error(error.localizedDescription)
            }
        }
    }
    
    /// Find and show top 3 reoccuring words in reviews
    func showTopThreeFrequentWords() {
        topThreeWordsState.value = .loading

        let request = TopKWordsUseCase.Request(k: 3, items: filteredReviews.compactMap{$0.content?.label})
        topKWordsUseCase.execute(request) { [weak self] (result) in
            guard let sSelf = self else {return}
        
            switch result{
            case .success(let response):
                sSelf.topThreeWordsState.value = .content(response.items)
            case .failure(let error):
                sSelf.topThreeWordsState.value = .error(error.localizedDescription)
            }
        }
    }
    
    //    MARK: - FeedViewModelOutput

    /// Observable data state for reviews
    var reviewsState: Observable<DataState<[ReviewCellModel]>> = Observable(.loading)
   
    /// Observable data state for top three words result
    var topThreeWordsState: Observable<DataState<[String]>> = Observable(.loading)
}
