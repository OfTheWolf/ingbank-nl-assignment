import Foundation

// MARK: - Entry
public struct Entry: Codable {
    public let author: Author?
    public let imVersion: Label?
    public let imRating: Label?
    public let id: Label?
    public let title: Label?
    public let content: Content?
    public let link: Link?
    public let imVoteSum: Label?
    public let imContentType: IMContentType?
    public let imVoteCount: Label?
    
    public func ratingAsInt() -> Int{
        return Int(imRating?.label ?? "0")!
    }
    
    enum CodingKeys: String, CodingKey{
        case author = "author"
        case imVersion = "im:version"
        case imRating = "im:rating"
        case id = "id"
        case title = "title"
        case content = "content"
        case link = "link"
        case imVoteSum = "im:voteSum"
        case imContentType = "im:contentType"
        case imVoteCount = "im:voteCount"
    }
}
