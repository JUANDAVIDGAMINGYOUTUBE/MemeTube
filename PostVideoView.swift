import SwiftUI

struct PostVideoView: View {
    @Binding var videos: [VideoPost]
    @State private var title = ""
    @State private var isVertical = false
    @State private var selectedVideoURL: URL?

    var body: some View {
        Form {
            TextField("Video Title", text: $title)
            Toggle("Vertical (MemeTube Short)", isOn: $isVertical)

            Button("Select Video") {
                // Implement video selection code here
            }
            
            if selectedVideoURL != nil {
                Button("Upload Video") {
                    if let videoURL = selectedVideoURL {
                        NetworkManager.shared.uploadVideo(videoURL: videoURL, title: title, isVertical: isVertical) { success in
                            if success {
                                NetworkManager.shared.fetchVideos { fetchedVideos in
                                    self.videos = fetchedVideos
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
