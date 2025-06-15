//
//  AddNewPostButton.swift
//  MarketplaceDemo
//
//  Created by Stefan Ducic on 15. 6. 2025..
//

import UIKit

class AddNewPostButton: UIButton
{
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        layer.cornerRadius = 0.5 * self.bounds.size.width
        clipsToBounds = true
    }
    
    private func setup()
    {
        //TODO: handle image?
        let addImage = UIImage(named: "btn_add")
        let tintedImage = addImage?.withRenderingMode(.alwaysTemplate)
        setImage(tintedImage, for: .normal)
        tintColor = UIColor.white
        backgroundColor = UIColor.blue
    }
}
