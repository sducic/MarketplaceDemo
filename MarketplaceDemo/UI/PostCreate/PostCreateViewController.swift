//
//  PostCreateViewController.swift
//  MarketplaceDemo
//
//  Created by Stefan Ducic on 16. 6. 2025..
//

import UIKit

class PostCreateViewController: MainViewController
{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var createNewPostButton: UIButton!
 
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func setupUI()
    {
        super.setupUI()
        
        setupCreateNewPostButton()
    }
    
    func setupCreateNewPostButton()
    {
        createNewPostButton.tintColor = UIColor.white
        createNewPostButton.backgroundColor = UIColor.blue
        createNewPostButton.setTitle("Create Post", for: .normal)
        createNewPostButton.layer.cornerRadius = 10
        createNewPostButton.clipsToBounds = true
        createNewPostButton.addTarget(self, action: #selector(createNewPostButtonTapped), for: .touchUpInside)
    }
    
    @objc func createNewPostButtonTapped()
    {
        print("test btn")
    }

}
