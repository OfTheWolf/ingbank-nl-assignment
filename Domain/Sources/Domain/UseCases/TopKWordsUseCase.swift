//
//  TopKWordsUseCase.swift
//  
//
//  Created by ugur on 30.10.2020.
//

import Foundation
import Entities

public final class TopKWordsUseCase: UseCase{
    public typealias Request = TopK<String>.Request
    public typealias Response = TopK<String>.Response

    public init(){}
    
    public func execute(_ request: Request, completion: @escaping (Result<Response, Error>) -> Void) {
        do {
            let wordsWithCounts = try topKFrequent(request.items, request.k)
            completion(.success(Response(items: wordsWithCounts)))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    public func cancel() {
        
    }
    
    // MARK: Local methods
    
    /// Find top k frequent words in a string array
    ///
    /// - Parameters:
    ///   - entries: reviews array
    ///   - k: top word count to filter
    /// - Returns: top k frequent words with counts
    private func topKFrequent(_ entries: [String], _ k: Int) throws -> [String] {
                
        let words = entriesToWords(entries)
        
        let wordFreq = Dictionary(words.map { ($0, 1) }, uniquingKeysWith: +)
        
        guard !wordFreq.isEmpty else {
            throw TopKError.empty
        }
        
        let sortedWords = wordFreq.keys.sorted {
            return wordFreq[$0]! > wordFreq[$1]!
        }

        let sorted = (0..<k).map {
            "\(sortedWords[$0]) \(wordFreq[sortedWords[$0]]!)"
        }
        return sorted
    }
    
    /// creates character set to split paragraph into words by omitting punctuation, whitespace and new lines
    private func createSeperators() -> CharacterSet{
        var separators = CharacterSet.whitespacesAndNewlines
        separators.formUnion(CharacterSet.punctuationCharacters)
        separators.remove(charactersIn: "'")
        return separators
    }
    
    /// Converts reviews array into words array by omitting the words less than 4 characters long
    ///
    /// - Parameter entries: reviews array
    /// - Returns: words array greater than 4 characters long
    private func entriesToWords(_ entries: [String]) -> [String]{
        return entries
            .joined(separator: " ")
            .components(separatedBy: createSeperators())
            .filter { (w) -> Bool in
                w.count > 4
            }
    }

}
