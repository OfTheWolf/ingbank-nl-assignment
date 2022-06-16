import Foundation

// MARK: - Feed
public struct Feed: Codable {
    public let author: Author?
    public let entry: [Entry]?
    public let updated: Label?
    public let rights: Label?
    public let title: Label?
    public let icon: Label?
    public let link: [Link]?
    public let id: Label?
}
