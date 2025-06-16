//
//  MainVC.swift
//  MarketplaceDemo
//
//  Created by Stefan Ducic on 13. 6. 2025..
//

import UIKit

class MainViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI()
    {
        overrideUserInterfaceStyle = .light
        configureNavigationControllerTitle()
    }
    
    func configureNavigationControllerTitle()
    {
        navigationItem.titleView = NavigationControllerTitleLabel()
    }
}
