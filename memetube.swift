import SwiftUI
import AVKit

struct VideoPost: Identifiable, Codable {
    let id = UUID()
    let title: String
    let isVertical: Bool
    let isLive: Bool
    let channelName: String
    let videoURL: URL
}

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
                    fetchVideos()
                }
            }
        }
    }

    private func fetchVideos() {
        guard let url = URL(string: "https://juan-david-gaming-server.com/api/videos") else {
            print("Invalid URL.")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Fetch error: \(error)")
                return
            }
            guard let data = data else {
                print("No data received.")
                return
            }
            do {
                // Decode JSON to VideoPost array
                let decodedVideos = try JSONDecoder().decode([VideoPost].self, from: data)
                DispatchQueue.main.async {
                    self.videos = decodedVideos
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }
}

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
                // Code to open file picker for video selection
                // Use `PHPickerViewController` for file selection on device (requires additional code)
            }
            
            if selectedVideoURL != nil {
                Button("Upload Video") {
                    if let videoURL = selectedVideoURL {
                        uploadVideo(videoURL: videoURL)
                    }
                }
            }
        }
    }

    private func uploadVideo(videoURL: URL) {
        guard let uploadURL = URL(string: "https://juan-david-gaming-server.com/api/upload") else {
            print("Invalid upload URL.")
            return
        }
        
        var request = URLRequest(url: uploadURL)
        request.httpMethod = "POST"
        request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.uploadTask(with: request, fromFile: videoURL) { data, response, error in
            if let error = error {
                print("Upload error: \(error)")
                return
            }
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Upload response: \(responseString)")
                fetchVideos()
            }
        }.resume()
    }

    private func fetchVideos() {
        guard let url = URL(string: "https://juan-david-gaming-server.com/api/videos") else {
            print("Invalid fetch URL.")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Fetch error: \(error)")
                return
            }
            guard let data = data else {
                print("No data received.")
                return
            }
            do {
                let decodedVideos = try JSONDecoder().decode([VideoPost].self, from: data)
                DispatchQueue.main.async {
                    self.videos = decodedVideos
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }
}

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
print("start")
print("Loaded")
if print("done")
else print("Wow")