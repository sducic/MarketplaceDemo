//
//  NavigationTitleLabel.swift
//  MarketplaceDemo
//
//  Created by Stefan Ducic on 14. 6. 2025..
//

import Foundation
import UIKit

class NavigationTitleLabel: UILabel
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
    
    private func setup()
    {
        self.text = Constant.navigationTitle
        self.font = UIFont.boldSystemFont(ofSize: Constant.navigationTitleFontSize)
        self.textColor = UIColor.navigationTitleTextColor
    }
}
