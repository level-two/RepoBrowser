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
  @IBOutlet weak var nameLabel: UILabel! 
  @IBOutlet weak var urlView: UITextView!
  @IBOutlet weak var descriptionText: UITextView!
  @IBOutlet weak var languageLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
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
    nameLabel.text = repo.fullRepoName
    urlView.text = repo.htmlURL
    descriptionText.text = repo.repoDescription
    languageLabel.text = repo.language
    dateLabel.text = repo.dateUpdated
  }
}
