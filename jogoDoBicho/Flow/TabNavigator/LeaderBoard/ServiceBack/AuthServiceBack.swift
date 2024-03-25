//
//  AuthServiceBack.swift
import Foundation

class AuthServiceBack {
    
    static let shared = AuthServiceBack()
    
    var token: String?
    
    let username = "admin"
    let password = "T11i3k7Ul2dAzMY"
    let url = URL(string: "https://pixel-art-backend-d2a8ccb45e48.herokuapp.com/login")!
    var request: URLRequest
    
    init() {
        request = URLRequest(url: url)
        request.httpMethod = "POST"
        let loginString = "\(username):\(password)"
        if let loginData = loginString.data(using: String.Encoding.utf8) {
            let base64LoginString = loginData.base64EncodedString(options: [])
            print("Login: \(base64LoginString)")
            request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        }
    }
    
    struct AuthResponse: Codable {
        let token: String?
    }

    func authenticate() async throws {
        do {
            let config = URLSessionConfiguration.default
                   config.urlCache = nil
                   config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
                   let session = URLSession(configuration: config)
            let (data, _) = try await session.data(for: request)
            let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
            self.token = authResponse.token
        } catch {
            throw error
        }
    }
}
