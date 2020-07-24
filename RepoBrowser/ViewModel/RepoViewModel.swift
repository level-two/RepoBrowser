//
//  RepoViewModel.swift
//  RepoBrowser
//
//  Created by malakoipechyva on 7/21/20.
//  Copyright © 2020 malakoipechyva. All rights reserved.
//

import Foundation
import CoreData

class RepoViewModel {
  let fullRepoName: String?
  let htmlURL: String?
  let repoDescription: String?
  let language: String?
  let dateUpdated: String?
  let avatarImgURL: URL?
  
  let dateFormatter = DateFormatter()
  
  init(repo: Repo) {
    self.fullRepoName = repo.fullRepoName
    self.htmlURL = repo.htmlURL
    self.repoDescription = repo.repoDescription
    self.language = repo.language
    dateFormatter.dateStyle = .full
    self.dateUpdated = dateFormatter.string(from: repo.dateUpdated!)
    self.avatarImgURL = repo.avatarImgURL
  }
  
}

extension RepoViewModel: Equatable {
  static func == (lhs: RepoViewModel, rhs: RepoViewModel) -> Bool {
    return lhs.fullRepoName == rhs.fullRepoName
  }
}
