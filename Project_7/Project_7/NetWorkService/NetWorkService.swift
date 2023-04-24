//
//  NetWorkService.swift
//  Exercicio 13
//
//  Created by franklin gaspar on 15/12/22.
//

import Foundation
import UIKit

enum  ResultError: Error {
    case badUrl
    case noData
    case invalidJson
}

class NetWorkManager {
    static let shared = NetWorkManager()
    
    // Constants
    struct Constant {
        static let newAPI = URL(
            string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=6321edd4dc824fdaab008fc14a97977c")
       

        static let newAPITwo = URL(
            string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=6321edd4dc824fdaab008fc14a97977c")

    }
    
    // MARK: Init
    private  init() {  }
    
    // MARK: Request Api
    func getNews(url: URL, completion: @escaping (Result<[Article],ResultError>) -> Void) {
        
        // Creat Configuration
        let configuration = URLSessionConfiguration.default
        
        // Creat Session
        let session = URLSession(configuration: configuration)
        
        // Creat Task
        let task = session.dataTask(with: url) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let data = data else { return  completion(.failure(.invalidJson
                  ))}
            
            do {
                
                let result = try? newJSONDecoder().decode(News.self, from: data)
                completion(.success(result?.articles ?? []))
                
            } catch let error as Error {
                print("Error info: \(error.localizedDescription)")
                completion(.failure(.noData))
                
            }
        }
        task.resume()
    }
    
    
}

