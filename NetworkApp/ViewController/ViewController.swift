//
//  ViewController.swift
//  NetworkApp
//
//  Created by Grigory Sapogov on 15.11.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var tableView = UITableView()
    
    var viewModel: ViewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layout()
        self.setupViewModel()
        self.setupTableView()
        self.updateData()
    }
    
    private var isAppearing = false
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.isAppearing = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.isAppearing = false
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    private func layout() {
        
        self.view.addSubview(tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
    }
    
    private func setupViewModel() {
        
        self.viewModel.fetchCompletion = { [weak self] error in
            
            guard let self = self else { return }
            
            if let error = error {
                print(error)
                return
            }
            
            if self.isAppearing {
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    private func updateData() {
        
        self.viewModel.fetchPost()
        
    }
    
    private func showPost(post: Post) {

        let postViewModel = PostViewModel(post: post)
        let postViewController = PostViewController()
        postViewController.viewModel = postViewModel

        self.navigationController?.pushViewController(postViewController, animated: true)
        
    }

    //MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = self.viewModel.posts[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = post.text
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        
        return cell
        
    }
    
    //MARK: - UITable View Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = self.viewModel.posts[indexPath.row]
        self.showPost(post: post)
    }
    
}

