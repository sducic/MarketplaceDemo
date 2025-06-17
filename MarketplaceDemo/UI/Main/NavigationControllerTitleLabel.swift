//
//  NavigationTitleLabel.swift
//  MarketplaceDemo
//
//  Created by Stefan Ducic on 14. 6. 2025..
//

import Foundation
import UIKit

class NavigationControllerTitleLabel: UILabel
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
        self.text = Constants.navigationTitle
        self.font = UIFont.boldSystemFont(ofSize: Constants.navigationTitleFontSize)
        self.textColor = UIColor.navigationTitleTextColor
    }
}
