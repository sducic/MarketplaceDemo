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
    //in case the requirement is to implement pagination with a limit of 20
    func testFetchPostPaginationLimit()
    {
        let pagination = Pagination(page: Constants.paginationStartPage, limit: Constants.paginationLimit)
        XCTAssertEqual(pagination.limit, 20)
    }

    //test NetworkManager fetch Post data
    func testNetworkManagerFetchPostDataSuccess() async throws
    {
        let urlString = "https://jsonplaceholder.typicode.com/posts/10"
        let post: Post = try await NetworkManager.shared.fetchData(urlString: urlString)
        XCTAssertEqual(post.id, 10)
    }
    
    //test APIEndpoint
    func testBaseURL()
    {
        let expectedURL = "https://jsonplaceholder.typicode.com"
        XCTAssertEqual(APIEndpoint.baseURL, expectedURL)
    }
    
    func testCreatePostURL()
    {
        let page = 1
        let limit = 20
        let expectedURL = "https://jsonplaceholder.typicode.com/posts?_page=1&_limit=20"
        XCTAssertEqual(APIEndpoint.createPostURL(page: page, limit: limit), expectedURL)
    }
        
    func testCreateCommentURL()
    {
        let postId = 5
        let limit = 20
        let expectedURL = "https://jsonplaceholder.typicode.com/comments?postId=5&_limit=20"
        XCTAssertEqual(APIEndpoint.createCommentURL(postId: postId, limit: limit), expectedURL)
    }
        
    func testCreateImageURL()
    {
        let width = 300
        let height = 200
        let expectedURL = "https://picsum.photos/300/200"
        XCTAssertEqual(APIEndpoint.createImageURL(width: width, height: height), expectedURL)
    }
        
    func testCreateNewPostURL()
    {
        let expectedURL = "https://jsonplaceholder.typicode.com/posts"
        XCTAssertEqual(APIEndpoint.createNewPostURL(), expectedURL)
    }
}
