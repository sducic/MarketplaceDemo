//
//  PostCVCell.swift
//  MarketplaceDemo
//
//  Created by Stefan Ducic on 14. 6. 2025..
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    func set(post: Post)
    {
        titleLabel.text = post.title
        bodyLabel.text = post.body
    }

}
