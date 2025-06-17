//
//  Pagination.swift
//  MarketplaceDemo
//
//  Created by Stefan Ducic on 17. 6. 2025..
//

import Foundation

struct Pagination
{
    var page = 1
    let limit = 20
    var isLoading = false

    mutating func nextPage()
    {
        page += 1
    }
}
