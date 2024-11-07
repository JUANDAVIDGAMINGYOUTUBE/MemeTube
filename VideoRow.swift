import SwiftUI

struct VideoRow: View {
    let video: VideoPost

    var body: some View {
        VStack(alignment: .leading) {
            Text(video.title)
                .font(.headline)
            Text("Channel: \(video.channelName)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}
