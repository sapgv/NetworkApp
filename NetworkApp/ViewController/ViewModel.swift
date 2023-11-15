//
//  ViewModel.swift
//  NetworkApp
//
//  Created by Grigory Sapogov on 15.11.2023.
//

import Foundation

enum ViewModelError: Error {
    
    case invalidUrl
    case invalidData
    
}

final class ViewModel {
    
    var posts: [Post] = []
    
    var fetchCompletion: ((Error?) -> Void)?
    
    init(posts: [Post] = []) {
        self.posts = posts
    }
    
    func fetchPost() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            self.fetchCompletion?(ViewModelError.invalidUrl)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    self.fetchCompletion?(error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.fetchCompletion?(ViewModelError.invalidData)
                }
                return
            }
            
            do {
                guard let array = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
                    DispatchQueue.main.async {
                        self.fetchCompletion?(ViewModelError.invalidData)
                    }
                    return
                }
                
                let posts = array.map { data in
                    Post(data: data)
                }
                
                self.posts = posts
                
                DispatchQueue.main.async {
                    self.fetchCompletion?(nil)
                }
                
            }
            catch {
                DispatchQueue.main.async {
                    self.fetchCompletion?(error)
                }
            }
            
        }
        
        task.resume()
        
    }
    
}
