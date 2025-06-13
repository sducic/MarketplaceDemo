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
        setupLabel()
    }
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        setupLabel()
    }
    
    private func setupLabel()
    {
        self.text = Constants.navigationTitle
        self.font = UIFont.boldSystemFont(ofSize: Constants.navigationTitleFontSize)
        self.textColor = UIColor.navigationTitleTextColor
    }
}
