//
//  ViewController.swift
//  MarketplaceDemo
//
//  Created by Stefan Ducic on 12. 6. 2025..
//

import UIKit

class PostListVC: MainVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    @IBOutlet weak var postsCollectionView: UICollectionView!
    var posts = [Post]()
    
    override func viewDidLoad()
    {
        fetchData()
        
        super.viewDidLoad()
        
        postsCollectionView.delegate = self
        postsCollectionView.dataSource = self

        let nib = UINib(nibName: "PostCollectionViewCell", bundle: nil)
        postsCollectionView.register(nib, forCellWithReuseIdentifier: "PostCollectionViewCell")
  
        
    }
    
    func fetchData()
    {
        let post1 = Post(userId: 1, id: 101, title: "First Post", body: "Test 1")
        let post2 = Post(userId: 2, id: 102, title: "Second Post", body: "Test 2")
        let post3 = Post(userId: 3, id: 103, title: "Third Post", body: "Test 3")

        posts = [post1, post2, post3]
    }
    

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
            return CGSize(width:collectionView.frame.width, height: 50)
    }

    
}

