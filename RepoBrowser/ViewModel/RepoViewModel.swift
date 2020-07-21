//
//  RepoViewModel.swift
//  RepoBrowser
//
//  Created by malakoipechyva on 7/21/20.
//  Copyright © 2020 malakoipechyva. All rights reserved.
//

import Foundation

struct RepoViewModel {
  let fullRepoName: String?
  let htmlURL: URL?
  let description: String?
  let language: String?
  let dateUpdated: Date?
  let avatarImgURL: URL?
  
  //MARK: Dependency injection
  init(repo: Repo) {
    self.fullRepoName = repo.fullRepoName
    self.htmlURL = repo.htmlURL
    self.description = repo.description
    self.language = repo.language
    self.dateUpdated = repo.dateUpdated
    self.avatarImgURL = repo.owner?.avatarImgURL
  }
  
}
