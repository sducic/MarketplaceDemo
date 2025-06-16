//
//  PostCVCell.swift
//  MarketplaceDemo
//
//  Created by Stefan Ducic on 14. 6. 2025..
//

import UIKit

class PostDetailCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    func set(comment: Comment)
    {
        nameLabel.text = comment.name
        emailLabel.text = comment.email
        bodyLabel.text = comment.body
    }

}
