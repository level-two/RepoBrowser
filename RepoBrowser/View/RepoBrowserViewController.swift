//
//  ViewController.swift
//  RepoBrowser
//
//  Created by malakoipechyva on 7/16/20.
//  Copyright © 2020 malakoipechyva. All rights reserved.
//

import UIKit

class RepoBrowserViewController: UIViewController {

  var gitHubApi = GitHubApi()
  var reposStore: ReposStore!
  
  @IBOutlet weak var searchTextField: UITextField!
  @IBOutlet weak var collectionView: UICollectionView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchTextField.delegate = self
  }


  @IBAction func searchButton(_ sender: Any) {
    searchTextField.endEditing(true)
  }
}

// MARK: - UITextFieldDelegate
extension RepoBrowserViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    searchTextField.endEditing(true)
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if let query = searchTextField.text {
      var gitHubURL: URL {
        return gitHubApi.makeGitHubURL(query: query)
      }
      print("\(gitHubURL)")
      
      reposStore.fetchRepos(url: gitHubURL) {
        (reposResult) in
        switch reposResult {
        case let .success(repos):
          print("Successfully found \(repos.count) repos.")
        case let .failure(error):
          print("Error downloading repos:  \(error) $$$$")

        }
      }
    } else {
      searchTextField.text = ""
    }
  }
  
  
}

