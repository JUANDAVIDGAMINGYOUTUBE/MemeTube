import Foundation

struct VideoPost: Identifiable, Codable {
    let id = UUID()
    let title: String
    let isVertical: Bool
    let isLive: Bool
    let channelName: String
    let videoURL: URL
}
