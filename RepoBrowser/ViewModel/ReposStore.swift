//
//  ReposStore.swift
//  RepoBrowser
//
//  Created by malakoipechyva on 7/20/20.
//  Copyright © 2020 malakoipechyva. All rights reserved.
//

import UIKit

enum RepoImageError: Error {
  case imageCreationError
  case missingImageUrl
}

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
  
  func fetchRepoImage(for repo: Repo, completion: @escaping (Result<UIImage, Error>) -> Void) {
    guard let repoOwnerPhotoURL = repo.owner?.avatarImgURL else {
      completion(.failure(RepoImageError.missingImageUrl))
      return
    }
    let request = URLRequest(url: repoOwnerPhotoURL)
    let task = session.dataTask(with: request) {
      (data, response, error) in
      let result = self.processRepoImageRequest(data: data, error: error)
       OperationQueue.main.addOperation {
      completion(result)
      }
    }
    task.resume()
  }
  
  func processRepoImageRequest(data: Data?, error: Error?) -> Result<UIImage, Error> {
    guard
      let imageData = data,
      let image = UIImage(data: imageData)
      else {
        if data == nil {
          return .failure(error!)
        } else {
          return .failure(RepoImageError.imageCreationError)
        }
    }
    return .success(image)
  }
}
