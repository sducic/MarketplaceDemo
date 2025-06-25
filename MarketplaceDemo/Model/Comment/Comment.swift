//
//  Comment.swift
//  MarketplaceDemo
//
//  Created by Stefan Ducic on 14. 6. 2025..
//

import Foundation

struct Comment: Codable
{
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
