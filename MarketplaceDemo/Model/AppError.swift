//
//  NetworkManagerError.swift
//  MarketplaceDemo
//
//  Created by Stefan Ducic on 17. 6. 2025..
//

import Foundation

enum AppError: Error
{
    case invalidURL
    case invalidResponse(statusCode: Int)
    case invalidStatusCode(statusCode: Int)
    case invalidDecoding
    case invalidImage
    case unknown
}
