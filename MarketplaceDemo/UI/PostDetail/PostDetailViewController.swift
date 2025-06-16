//
//  PostDetailViewController.swift
//  MarketplaceDemo
//
//  Created by Stefan Ducic on 16. 6. 2025..
//

import UIKit

class PostDetailViewController: MainViewController
{
    @IBOutlet weak var postImageView: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        loadImage()
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

}
