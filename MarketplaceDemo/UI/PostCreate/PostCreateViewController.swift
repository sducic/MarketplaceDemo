//
//  PostCreateViewController.swift
//  MarketplaceDemo
//
//  Created by Stefan Ducic on 16. 6. 2025..
//

import UIKit

class PostCreateViewController: MainViewController
{
    var newPost = NewPost()
    
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
        titleTextField.delegate = self
        aboutTextView.delegate = self
        setupCreateNewPostButton()
        addTapGestureToDismissKeyboard()
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
        Task {
                do
                {
                    print(newPost)
                    let newPost = try await NetworkManager.shared.createNewPostRequest(post: newPost)
                    print("Created post with id: \(newPost.title)")
                } catch {
                    print("Failed to create post: \(error)")
                }
            }
    }
    
    func addTapGestureToDismissKeyboard()
    {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapToDismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTapToDismissKeyboard()
    {
        view.endEditing(true)
    }
}

extension PostCreateViewController: UITextFieldDelegate, UITextViewDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if textField == titleTextField
        {
            newPost.title = textField.text ?? ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if textView == aboutTextView
        {
            newPost.body = textView.text ?? ""
        }
    }
}

