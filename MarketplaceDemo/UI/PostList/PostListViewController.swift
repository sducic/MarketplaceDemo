//
//  ViewController.swift
//  MarketplaceDemo
//
//  Created by Stefan Ducic on 12. 6. 2025..
//

import UIKit

class PostListViewController: MainViewController
{
    var posts = [Post]()
    var page = 1
    let limit = 20
    
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
  
        setupUI()
        fetchPostData(page: page, limit: limit)
    }
    
    override func setupUI()
    {
        super.setupUI()
        setupPostCollectionView()
        setupAddNewPostButton()
    }
    
    func setupPostCollectionView()
    {
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        
        registerPostCell()
    }
    
    func registerPostCell()
    {
        let nib = UINib(nibName: Constants.postCVCellIdentifier, bundle: nil)
        postCollectionView.register(nib, forCellWithReuseIdentifier: Constants.postCVCellIdentifier)
    }
    
    func setupAddNewPostButton()
    {
        addNewPostButton.translatesAutoresizingMaskIntoConstraints = false
        postFooterView.addSubview(addNewPostButton)
        
        NSLayoutConstraint.activate([
            addNewPostButton.centerXAnchor.constraint(equalTo: postFooterView.centerXAnchor),
            addNewPostButton.centerYAnchor.constraint(equalTo: postFooterView.centerYAnchor),
            addNewPostButton.widthAnchor.constraint(equalToConstant: 45),
            addNewPostButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func fetchPostData(page: Int, limit: Int)
    {
        Task {
                do {
                    print("CALL")
                    let newPosts = try await NetworkManager.shared.fetchPost(page: page, limit: limit)
                    guard !newPosts.isEmpty else { return }
                    
                    self.posts.append(contentsOf: newPosts)
                    self.page += 1
                    
                    DispatchQueue.main.async    {
                        self.postCollectionView.reloadData()
                    }
                } catch {
                    print("Error: \(error)")
                }
            }
    }
    
    //TODO: update CollectionView with the new data instead of reload?
    
}


extension PostListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.postCVCellIdentifier, for: indexPath) as! PostCollectionViewCell
        cell.set(post: posts[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PostDetailVC") as! PostDetailViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width:collectionView.frame.width * Constants.postCellWidthRatio, height: Constants.postCellHeightSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        if indexPath.item == posts.count - 1
        {
            print("end")
            fetchPostData(page: page, limit: limit)
        }
    }
}
