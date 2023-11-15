//
//  PostViewController.swift
//  NetworkApp
//
//  Created by Grigory Sapogov on 15.11.2023.
//

import UIKit

final class PostViewController: UIViewController {
    
    var viewModel: PostViewModel!
    
    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.layout()
        self.setupLabel()
    }
    
    deinit {
        print("Deinit PostViewController")
    }
    
    private func setupLabel() {
        
        self.label.text = self.viewModel.post.text
        self.label.numberOfLines = 0
        self.label.lineBreakMode = .byWordWrapping
        self.label.backgroundColor = .systemGreen
        
    }
    
    private func layout() {
        
        self.view.addSubview(label)
        
        self.label.translatesAutoresizingMaskIntoConstraints = false
        
        self.label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        self.label.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
    }
    
}
