//
//  PostDetailViewController.swift
//  MarketplaceDemo
//
//  Created by Stefan Ducic on 16. 6. 2025..
//

import UIKit

class PostDetailViewController: MainViewController
{
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
        loadComment()
    }
    
    func loadImage()
    {
        Task {
                do {
                    let postImage = try await NetworkManager.shared.fetchImage()
                    
                    DispatchQueue.main.async    {
                        self.postImageView.image = postImage
                    }
                } catch {
                    print("Error: \(error)")
                }
            }
    }
    
    func loadComment()
    {
        Task {
                do {
                    let comments = try await NetworkManager.shared.fetchComment()
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
        
        registerPostCell()
    }
    
    func registerPostCell()
    {
        let nib = UINib(nibName: "PostDetailCollectionViewCell", bundle: nil)
        postDetailCollectionView.register(nib, forCellWithReuseIdentifier: "PostDetailCollectionViewCell")
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostDetailCollectionViewCell", for: indexPath) as! PostDetailCollectionViewCell
        cell.set(comment: comments[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
       
        //TODO: refactor
        return CGSize(width:collectionView.frame.width * Constants.postCellWidthRatio, height: 80)
    }
    
}
