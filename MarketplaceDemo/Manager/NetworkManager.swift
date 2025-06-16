//
//  NetworkManager.swift
//  MarketplaceDemo
//
//  Created by Stefan Ducic on 16. 6. 2025..
//

import Foundation


class NetworkManager
{
    static let shared = NetworkManager()
        
    private init() {}
    
    //TODO: refactor
    func fetchPost(page: Int, limit: Int) async throws -> [Post]
    {
        let urlString = "https://jsonplaceholder.typicode.com/posts?_page=\(page)&_limit=\(limit)"
        
        guard let url = URL(string: urlString) else {
            throw AppError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else  {
                throw AppError.invalidResponse(statusCode: -1)
        }

        guard httpResponse.statusCode == 200 else   {
                throw AppError.invalidResponse(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder ()
            return try decoder.decode([Post].self, from: data)
        } catch {
            throw AppError.invalidDecoding
        }
    }
    
}

enum AppError: Error
{
    case invalidURL
    case invalidResponse(statusCode: Int)
    case invalidDecoding
    case unknown
}
