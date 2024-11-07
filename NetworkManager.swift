import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let serverBaseURL = "https://juan-david-gaming-server.com/api"
    
    private init() {}
    
    func fetchVideos(completion: @escaping ([VideoPost]) -> Void) {
        guard let url = URL(string: "\(serverBaseURL)/videos") else {
            print("Invalid URL.")
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Fetch error: \(error)")
                completion([])
                return
            }
            guard let data = data else {
                print("No data received.")
                completion([])
                return
            }
            do {
                let videos = try JSONDecoder().decode([VideoPost].self, from: data)
                DispatchQueue.main.async {
                    completion(videos)
                }
            } catch {
                print("Decoding error: \(error)")
                completion([])
            }
        }.resume()
    }
    
    func uploadVideo(videoURL: URL, title: String, isVertical: Bool, completion: @escaping (Bool) -> Void) {
        guard let uploadURL = URL(string: "\(serverBaseURL)/upload") else {
            print("Invalid upload URL.")
            completion(false)
            return
        }
        
        var request = URLRequest(url: uploadURL)
        request.httpMethod = "POST"
        request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.uploadTask(with: request, fromFile: videoURL) { data, response, error in
            if let error = error {
                print("Upload error: \(error)")
                completion(false)
                return
            }
            completion(true)
        }.resume()
    }
}
