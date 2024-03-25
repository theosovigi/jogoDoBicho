//
//  GetServiceBack.swift



import Foundation

enum UserServiceError: Error {
    case unkonwn
    case noData
}

class GetServiceBack {

    static let shared = GetServiceBack()
    
    private init() {}
    
    private let urlString = "https://pixel-art-backend-d2a8ccb45e48.herokuapp.com/api/players"

    func fetchData(successCompletion: @escaping([User]) -> Void, errorCompletion: @escaping (Error) -> Void) {

        guard let url = URL(string: urlString) else {
            print("Неверный URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
     
        
        guard let token = AuthServiceBack.shared.token else { return }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    errorCompletion(UserServiceError.noData)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    errorCompletion(UserServiceError.unkonwn)
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let users = try decoder.decode([User].self, from: data)
                DispatchQueue.main.async {
                    successCompletion(users)
                }
            }catch {
                print("error", error)
                
                DispatchQueue.main.async {
                    errorCompletion(error)
                }
            }
        }
        task.resume()
    }
}
