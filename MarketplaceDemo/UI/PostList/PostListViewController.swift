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
    var pagination = Pagination(page: Constants.paginationStartPage, limit: Constants.paginationLimit)
    
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
        fetchPostData(page: pagination.page, limit: pagination.limit)
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
        guard !pagination.isLoading else { return }
        pagination.isLoading = true
        
        Task {
                do {
                    let newPosts: [Post] = try await NetworkManager.shared.fetchData(urlString: APIEndpoint.createPostURL(page: page, limit: limit))
                    guard !newPosts.isEmpty else
                    {
                        pagination.isLoading = false
                        return
                    }

                    self.posts.append(contentsOf: newPosts)
                    self.pagination.nextPage()
                    
                    DispatchQueue.main.async    {
                        self.postCollectionView.reloadData()
                    }
                } catch {
                    print("Error: \(error)")
                }
                self.pagination.isLoading = false
            }
    }
    
    @objc private func addNewPostTapped()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let postCreateVC = storyboard.instantiateViewController(withIdentifier: "PostCreateViewController") as! PostCreateViewController
        navigationController?.pushViewController(postCreateVC, animated: true)
    }
}

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
            fetchPostData(page: pagination.page, limit: pagination.limit)
        }
    }
}
