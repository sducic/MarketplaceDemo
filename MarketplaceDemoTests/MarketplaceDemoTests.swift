//
//  MarketplaceDemoTests.swift
//  MarketplaceDemoTests
//
//  Created by Stefan Ducic on 17. 6. 2025..
//

import XCTest
@testable import MarketplaceDemo

final class MarketplaceDemoTests: XCTestCase
{
    //In case the requirement is to implement pagination with a limit of 20 when loading new posts
    func testFetchPostPaginationLimit()
    {
        let pagination = Pagination()
        XCTAssertEqual(pagination.limit, 20)
    }


}
