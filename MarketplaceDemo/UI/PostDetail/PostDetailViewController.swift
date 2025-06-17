//
//  PostDetailViewController.swift
//  MarketplaceDemo
//
//  Created by Stefan Ducic on 16. 6. 2025..
//

import UIKit

class PostDetailViewController: MainViewController
{
    var postId: Int?
    var comments = [Comment]()
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postDetailCollectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }
    
    override func setupUI()
    {
        super.setupUI()
        setupDetailPostCollectionView()
    }
    
    func fetchData()
    {
        loadImage()
        //TODO: handle error
        loadComment(postId: postId ?? 0)
    }
    
    func loadImage()
    {
        Task {
                do {
                    //TODO: url
                    let urlString = "https://picsum.photos/300/200"
                    let postImage = try await NetworkManager.shared.fetchImage(urlString: urlString)
                    
                    DispatchQueue.main.async    {
                        self.postImageView.image = postImage
                    }
                } catch {
                    print("Error: \(error)")
                }
            }
    }
    
    func loadComment(postId: Int)
    {
        Task {
                do {
                    //TODO: url
                    let urlString = "https://jsonplaceholder.typicode.com/comments?postId=\(postId)"
                    let comments: [Comment] = try await NetworkManager.shared.fetchData(urlString: urlString)
                    guard !comments.isEmpty else { return }
                    
                    self.comments = comments
                    
                    DispatchQueue.main.async    {
                        self.postDetailCollectionView.reloadData()
                    }
                } catch {
                    print("Error: \(error)")
                }
            }
    }
    
    func setupDetailPostCollectionView()
    {
        postDetailCollectionView.delegate = self
        postDetailCollectionView.dataSource = self
        registerPostDetailCell()
    }
    
    func registerPostDetailCell()
    {
        let nib = UINib(nibName: PostDetailCollectionViewCell.reuseIdentifier, bundle: nil)
        postDetailCollectionView.register(nib, forCellWithReuseIdentifier: PostDetailCollectionViewCell.reuseIdentifier)
    }
}

extension PostDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        //TODO: refactor
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostDetailCollectionViewCell.reuseIdentifier, for: indexPath) as! PostDetailCollectionViewCell
        cell.set(comment: comments[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
       
        //TODO: refactor
        return CGSize(width:collectionView.frame.width * Constants.cellWidthRatio, height: Constants.postDetailCellHeightSize)
    }
    
}
