//
//  ReposStore.swift
//  RepoBrowser
//
//  Created by malakoipechyva on 7/20/20.
//  Copyright © 2020 malakoipechyva. All rights reserved.
//

import Foundation

class ReposStore {
  
  var gitHubApi = GitHubApi()
  
  let session: URLSession = {
    let config = URLSessionConfiguration.default
    return URLSession(configuration: config)
  }()
  
  func fetchRepos(url: URL?, completion: @escaping (Result<[Repo], Error>) -> Void) {
    if let requestUrl = url {
      let task = session.dataTask(with: requestUrl) { (data, response, error) in
        let result = self.processReposRequest(data: data, error: error)
        OperationQueue.main.addOperation {
          completion(result)
        }
      }
      task.resume()
    }
  }
  
  func processReposRequest(data: Data?, error: Error?) -> Result<[Repo], Error> {
    guard let reposData = data else {
      return .failure(error!)
    }
    return gitHubApi.parseJSON(reposData: reposData)
  }
}
