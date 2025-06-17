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
                    let postImage = try await NetworkManager.shared.fetchImage(urlString: APIEndpoint.createImageURL(width: Constants.postImageSizeWidth, height: Constants.postImageSizeHeight))
                    
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
                    let comments: [Comment] = try await NetworkManager.shared.fetchData(urlString: APIEndpoint.createCommentURL(postId: postId, limit: Constants.numOfCommentsLimit))
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
        //return min(comments.count, Constants.numOfComments)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostDetailCollectionViewCell.reuseIdentifier, for: indexPath) as! PostDetailCollectionViewCell
        cell.set(comment: comments[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
       
        return CGSize(width:collectionView.frame.width * Constants.cellWidthRatio, height: Constants.postDetailCellHeightSize)
    }
    
}
