//
//  RepoDetailViewController.swift
//  RepoBrowser
//
//  Created by malakoipechyva on 7/22/20.
//  Copyright © 2020 malakoipechyva. All rights reserved.
//

import UIKit

class RepoDetailViewController: UIViewController {
  
  var repo: RepoViewModel!
  var reposStore: ReposStore!
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel! {
    didSet {
      nameLabel.text = repo.fullRepoName
    }
  }
  @IBOutlet weak var urlView: UITextView! {
    didSet {
      urlView.text = repo.htmlURL
    }
  }
  @IBOutlet weak var descriptionText: UITextView! {
    didSet {
      descriptionText.text = repo.description
    }
  }
  @IBOutlet weak var languageLabel: UILabel! {
    didSet {
      languageLabel.text = repo.language
    }
  }
  @IBOutlet weak var dateLabel: UILabel! {
    didSet {
      dateLabel.text = repo.dateUpdated
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    reposStore.fetchRepoImage(for: repo) { (result) -> Void in
      switch result {
      case let .success(image):
        self.imageView.image = image
      case let .failure(error):
        print("Error fetching image for repo \(error)")
      }
    }
  }
}
