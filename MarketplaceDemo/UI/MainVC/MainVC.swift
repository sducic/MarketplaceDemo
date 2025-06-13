//
//  MainVC.swift
//  MarketplaceDemo
//
//  Created by Stefan Ducic on 13. 6. 2025..
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light
        
        configureNavigationTitle()
    }
    
    func configureNavigationTitle()
    {
        let headerTitle = UILabel()
        headerTitle.font = UIFont.boldSystemFont(ofSize: 18)
        headerTitle.text = "Marketplace"
        headerTitle.textColor = UIColor.black
        navigationItem.titleView = headerTitle
    }
    

}
