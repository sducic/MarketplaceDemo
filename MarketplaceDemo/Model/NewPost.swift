//
//  NewPost.swift
//  MarketplaceDemo
//
//  Created by Stefan Ducic on 16. 6. 2025..
//

import Foundation

struct NewPost: Codable
{
    var userId: Int
    var title: String
    var body: String
    
    init(userId: Int = Constants.userId, title: String = "", body: String = "")
    {
            self.userId = userId
            self.title = title
            self.body = body
    }
}
