//
//  Repo.swift
//  RepoBrowser
//
//  Created by malakoipechyva on 7/20/20.
//  Copyright © 2020 malakoipechyva. All rights reserved.
//

import Foundation

struct GitRepo: Codable {
  let fullRepoName: String?
  let owner: Owner?
  let htmlURL: String?
  let repoDescription: String?
  let language: String?
  let dateUpdated: Date?
  let stars: Int32?
  
  enum CodingKeys: String, CodingKey {
    case fullRepoName = "full_name"
    case owner
    case htmlURL = "html_url"
    case repoDescription
    case language
    case dateUpdated = "updated_at"
    case stars = "stargazers_count"
  }
}

struct Owner: Codable {
  let avatarImgURL: URL?
  
  enum CodingKeys: String, CodingKey {
    case avatarImgURL = "avatar_url"
  }
}
