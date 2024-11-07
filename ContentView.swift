import SwiftUI

struct ContentView: View {
    @State private var videos: [VideoPost] = []
    @State private var isShowingPostView = false

    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    isShowingPostView.toggle()
                }) {
                    Text("Post a Video or Meme")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $isShowingPostView) {
                    PostVideoView(videos: $videos)
                }

                List(videos) { video in
                    VideoRow(video: video)
                }
                .navigationTitle("MemeTube")
                .onAppear {
                    NetworkManager.shared.fetchVideos { fetchedVideos in
                        self.videos = fetchedVideos
                    }
                }
            }
        }
    }
}
