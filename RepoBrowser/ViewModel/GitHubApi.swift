//
//  GitHubApi.swift
//  RepoBrowser
//
//  Created by malakoipechyva on 7/20/20.
//  Copyright © 2020 malakoipechyva. All rights reserved.
//

import Foundation

struct GitHubApi {
  
  let baseURLString = "https://api.github.com/search/repositories"
  
  
  func makeGitHubURL(query: String) -> URL {
    var components = URLComponents(string: baseURLString)!
    var queryItems = [URLQueryItem]()
    let baseParams = [
      "q": query,
      "sort": "stars",
      "order": "desc",
      "per_page": "100"
    ]
    for (key, value) in baseParams {
      let item = URLQueryItem(name: key, value: value)
      queryItems.append(item)
    }
    components.queryItems = queryItems
    return components.url!
  }
  
  
}
