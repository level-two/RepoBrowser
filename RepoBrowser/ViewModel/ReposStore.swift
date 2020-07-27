//
//  ReposStore.swift
//  RepoBrowser
//
//  Created by malakoipechyva on 7/20/20.
//  Copyright © 2020 malakoipechyva. All rights reserved.
//

import UIKit
import CoreData

enum RepoImageError: Error {
  case imageCreationError
  case missingImageUrl
}

class ReposStore {
  
  var gitHubApi = GitHubApi()
  
  let persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "RepoBrowser")
    container.loadPersistentStores { (description, error) in
      if let error = error {
        print("Error setting up coredata \(error)")
      }
    }
    return container
  }()
  
  let session: URLSession = {
    let config = URLSessionConfiguration.default
    return URLSession(configuration: config)
  }()
  
  func fetchRepos(url: URL?, completion: @escaping (Result<[Repo], Error>) -> Void) {
    if let requestUrl = url {
      let task = session.dataTask(with: requestUrl) { (data, response, error) in
       var result = self.processReposRequest(data: data, error: error)
        if case .success = result {
          do {
            try self.persistentContainer.viewContext.save()
          } catch {
            result = .failure(error)
          }
        }
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
    let context = persistentContainer.viewContext
    
    switch gitHubApi.parseJSON(reposData: reposData) {
    case let .success(gitRepos):
      let repos = gitRepos.map { gitRepo -> Repo in
        var repo: Repo!
        context.performAndWait {
          repo = Repo(context: context)
          repo.dateUpdated = gitRepo.dateUpdated
          repo.fullRepoName = gitRepo.fullRepoName
          repo.htmlURL = gitRepo.htmlURL
          repo.language = gitRepo.language
          repo.repoDescription = gitRepo.repoDescription
          repo.avatarImgURL = gitRepo.owner?.avatarImgURL
        }
        return repo
      }
      return .success(repos)
    case let .failure(error):
      return .failure(error)
    }
  }
  
  func fetchRepoImage(for repo: RepoViewModel, completion: @escaping (Result<UIImage, Error>) -> Void) {
    guard let repoOwnerPhotoURL = repo.avatarImgURL else {
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
  
  func fetchReposOnLoad(completion: @escaping (Result<[Repo], Error>) -> Void) {
    let fetchRequest: NSFetchRequest<Repo> = Repo.fetchRequest()
    let sortByName = NSSortDescriptor(key: #keyPath(Repo.fullRepoName),
                                           ascending: true)
    fetchRequest.sortDescriptors = [sortByName]
    
    let viewContext = persistentContainer.viewContext
    viewContext.perform {
      do {
        let allRepos = try viewContext.fetch(fetchRequest)
        completion(.success(allRepos))
      } catch {
        completion(.failure(error))
      }
    }
  }
}
