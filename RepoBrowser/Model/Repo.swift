//
//  Repo.swift
//  RepoBrowser
//
//  Created by malakoipechyva on 7/20/20.
//  Copyright © 2020 malakoipechyva. All rights reserved.
//

import Foundation

struct Repo: Codable {
  let fullRepoName: String?
  let owner: Owner?
  let htmlURL: URL?
  let description: String?
  let language: String?
  let dateUpdated: Date?
  
  enum CodingKeys: String, CodingKey {
    case fullRepoName = "full_name"
    case owner
    case htmlURL = "html_url"
    case description
    case language
    case dateUpdated = "updated_at"
  }
}

struct Owner: Codable {
  let avatarImgURL: URL?
  
  enum CodingKeys: String, CodingKey {
    case avatarImgURL = "avatar_url"
  }
}
