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
    var isLoading = false
    
    
    @IBOutlet weak var postCollectionView: UICollectionView!
    @IBOutlet weak var postFooterView: UIView!
    
    private lazy var addNewPostButton: AddNewPostButton = {
            let button = AddNewPostButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(addNewPostTapped), for: .touchUpInside)
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
        let nib = UINib(nibName: PostCollectionViewCell.reuseIdentifier, bundle: nil)
        postCollectionView.register(nib, forCellWithReuseIdentifier: PostCollectionViewCell.reuseIdentifier)
    }
    
    func setupAddNewPostButton()
    {
        addNewPostButton.translatesAutoresizingMaskIntoConstraints = false
        postFooterView.addSubview(addNewPostButton)
        
        NSLayoutConstraint.activate([
            addNewPostButton.centerXAnchor.constraint(equalTo: postFooterView.centerXAnchor),
            addNewPostButton.centerYAnchor.constraint(equalTo: postFooterView.centerYAnchor),
            addNewPostButton.widthAnchor.constraint(equalToConstant: Constants.addNewPostButtonSize),
            addNewPostButton.heightAnchor.constraint(equalToConstant: Constants.addNewPostButtonSize)
        ])
    }
    
    func fetchPostData(page: Int, limit: Int)
    {
        guard !isLoading else { return }
        isLoading = true
        
        Task {
                do {
                    let newPosts: [Post] = try await NetworkManager.shared.fetchData(urlString: APIEndpoint.createPostURL(page: page, limit: limit))
                    guard !newPosts.isEmpty else
                    {
                        isLoading = false
                        return
                    }

                    self.posts.append(contentsOf: newPosts)
                    self.page += 1
                    
                    DispatchQueue.main.async    {
                        self.postCollectionView.reloadData()
                        self.isLoading = false
                    }
                } catch {
                    print("Error: \(error)")
                    DispatchQueue.main.async    {
                        self.isLoading = false
                    }
                }
            }
    }
    
    @objc private func addNewPostTapped()
    {
        //TODO: refactor?
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let postCreateVC = storyboard.instantiateViewController(withIdentifier: "PostCreateViewController") as! PostCreateViewController
        navigationController?.pushViewController(postCreateVC, animated: true)
    }
}

//TODO: update CollectionView with the new data instead of reload?
extension PostListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.reuseIdentifier, for: indexPath) as! PostCollectionViewCell
        cell.set(post: posts[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PostDetailViewController") as! PostDetailViewController
        viewController.postId = posts[indexPath.item].id
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width:collectionView.frame.width * Constants.cellWidthRatio, height: Constants.postCellHeightSize)
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
