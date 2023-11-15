//
//  Post.swift
//  NetworkApp
//
//  Created by Grigory Sapogov on 15.11.2023.
//

import Foundation

final class Post {
    
    let text: String
    
    init(text: String) {
        self.text = text
    }
    
    init(data: [String: Any]) {
        self.text = data["body"] as? String ?? ""
    }
    
}
