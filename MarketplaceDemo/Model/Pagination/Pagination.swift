//
//  Pagination.swift
//  MarketplaceDemo
//
//  Created by Stefan Ducic on 17. 6. 2025..
//

import Foundation

struct Pagination
{
    var page : Int
    let limit : Int
    var isLoading : Bool = false
    
    init(page: Int, limit: Int)
    {
        self.page = page
        self.limit = limit
    }

    mutating func nextPage()
    {
        page += 1
    }
}
