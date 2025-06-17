//
//  APIEndpoint.swift
//  MarketplaceDemo
//
//  Created by Stefan Ducic on 17. 6. 2025..
//

import Foundation

struct APIEndpoint
{
    static let baseURL = "https://jsonplaceholder.typicode.com"
    
    static func createPostURL(page: Int, limit: Int) -> String
    {
        return "\(baseURL)/posts?_page=\(page)&_limit=\(limit)"
    }
    
    static func createCommentURL(postId: Int, limit: Int) -> String
    {
        return "\(baseURL)/comments?postId=\(postId)&_limit=\(limit)"
    }
    
    static func createImageURL(width: Int, height: Int) -> String
    {
        return "https://picsum.photos/\(width)/\(height)"
    }
}
