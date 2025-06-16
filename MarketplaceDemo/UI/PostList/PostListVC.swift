//
//  ViewController.swift
//  MarketplaceDemo
//
//  Created by Stefan Ducic on 12. 6. 2025..
//

import UIKit

class PostListVC: MainVC
{
    var posts = [Post]()
    
    @IBOutlet weak var postCollectionView: UICollectionView!
    @IBOutlet weak var postFooterView: UIView!
    
    private lazy var addNewPostButton: AddNewPostButton = {
            let button = AddNewPostButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            //button.addTarget(self, action: #selector(addNewPostTapped), for: .touchUpInside)
            return button
        }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
  
        setupPostCollectionView()
        setupAddNewPostButton()
        
        fetchData()
    }
    
    
    func setupPostCollectionView()
    {
        postCollectionView.delegate = self
        postCollectionView.dataSource = self

        let nib = UINib(nibName: "PostCollectionViewCell", bundle: nil)
        postCollectionView.register(nib, forCellWithReuseIdentifier: "PostCollectionViewCell")
    }
    
    
    func setupAddNewPostButton()
    {
        addNewPostButton.translatesAutoresizingMaskIntoConstraints = false
        postFooterView.addSubview(addNewPostButton)
        
        NSLayoutConstraint.activate([
            addNewPostButton.centerXAnchor.constraint(equalTo: postFooterView.centerXAnchor),
            addNewPostButton.centerYAnchor.constraint(equalTo: postFooterView.centerYAnchor),
            addNewPostButton.widthAnchor.constraint(equalToConstant: 50),
            addNewPostButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func fetchData()
    {
        Task {
                do {
                    let posts = try await NetworkManager.shared.fetchPost()
                    self.posts = posts
                    self.postCollectionView.reloadData()
                } catch {
                    print("Error: \(error)")
                }
            }
    }
    
}


extension PostListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as! PostCollectionViewCell
        cell.set(post: posts[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width:collectionView.frame.width, height: Constants.postCellHeightSize)
    }
}
