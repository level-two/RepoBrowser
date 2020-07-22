//
//  GitHubApi.swift
//  RepoBrowser
//
//  Created by malakoipechyva on 7/20/20.
//  Copyright © 2020 malakoipechyva. All rights reserved.
//

import Foundation

struct Repos: Decodable {
  let repo: [Repo]
  
  enum CodingKeys: String, CodingKey {
    case repo = "items"
  }
}

struct GitHubApi {
  
  let baseURLString = "https://api.github.com/search/repositories"
  
  
  func makeGitHubURL(query: String) -> URL {
    var components = URLComponents(string: baseURLString)!
    var queryItems = [URLQueryItem]()
    let baseParams = [
      "q": query,
      "sort": "stars",
      "order": "desc",
      "per_page": "1000"
    ]
    for (key, value) in baseParams {
      let item = URLQueryItem(name: key, value: value)
      queryItems.append(item)
    }
    components.queryItems = queryItems
    return components.url!
  }
  
  func parseJSON(reposData: Data) -> Result<[Repo], Error> {
    let decoder = JSONDecoder()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    decoder.dateDecodingStrategy = .formatted(dateFormatter)
    do {
      let decodedData = try decoder.decode(Repos.self, from: reposData)
      return .success(decodedData.repo)
    } catch {
      return .failure(error)
    }
    
  }
  
  
}
