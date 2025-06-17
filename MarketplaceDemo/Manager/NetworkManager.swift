//
//  NetworkManager.swift
//  MarketplaceDemo
//
//  Created by Stefan Ducic on 16. 6. 2025..
//

import Foundation
import UIKit

class NetworkManager
{
    static let shared = NetworkManager()
    private init() {}
    
    //TODO: refactor NetworkManager
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
    
    //TODO: handle errors
    func fetchImage() async throws -> UIImage
    {
        let urlString = "https://picsum.photos/300/200"
        
        guard let url = URL(string: urlString) else {
            throw AppError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let image = UIImage(data: data) else {
            throw AppError.invalidImage
        }
        
        return image
    }
    
    func fetchComment(postId: Int) async throws -> [Comment]
    {
        let urlString = "https://jsonplaceholder.typicode.com/comments?postId=\(postId)"
        
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
            return try decoder.decode([Comment].self, from: data)
        } catch {
            throw AppError.invalidDecoding
        }
    }
    
    
    func createNewPostRequest(post: NewPost) async throws -> NewPost
    {
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        guard let url = URL(string: urlString) else {
            throw AppError.invalidURL
        }
            
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
        let jsonData = try JSONEncoder().encode(post)
        request.httpBody = jsonData
            
        let (data, response) = try await URLSession.shared.data(for: request)
            
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw AppError.invalidStatusCode(statusCode: -1)
        }
            
        guard (200...299).contains(statusCode) else {
            throw AppError.invalidStatusCode(statusCode: statusCode)
        }
            
        let decodedResponse = try JSONDecoder().decode(NewPost.self, from: data)
            
        return decodedResponse
    }
    
}

