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
  let repoDataSource = RepoDataSource()
  
  @IBOutlet weak var searchTextField: UITextField!
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchTextField.delegate = self
    collectionView.dataSource = repoDataSource
    collectionView.delegate = self
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "showRepo":
      if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
        let repo = repoDataSource.repo[selectedIndexPath.row]
        let destinationVC = segue.destination as! RepoDetailViewController
        destinationVC.repo = repo
        destinationVC.reposStore = reposStore
      }
    default:
      preconditionFailure("Unexpected segue identifier.")
    }
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
      reposStore.fetchRepos(url: gitHubURL) {
        (reposResult) in
        switch reposResult {
        case let .success(repos):
          self.repoDataSource.repo = repos.map({return RepoViewModel(repo: $0 )})
          print("Successfully found \(repos.count) repos.")
        case let .failure(error):
          self.repoDataSource.repo.removeAll()
          print("Error downloading repos:  \(error) $$$$")
        }
        self.collectionView.reloadSections(IndexSet(integer: 0))
      }
    } else {
      searchTextField.text = ""
    }
  }
}

// MARK: - UICollectionViewDelegate
extension RepoBrowserViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    let repoForDisplay = repoDataSource.repo[indexPath.row]
    
    reposStore.fetchRepoImage(for: repoForDisplay) { (result) -> Void in
      guard let repoImageIndex = self.repoDataSource.repo.firstIndex(of: repoForDisplay),
        case let .success(image) = result else {
          return
      }
      let repoImageIndexPath = IndexPath(item: repoImageIndex, section: 0)
      if let cell = self.collectionView.cellForItem(at: repoImageIndexPath) as? RepoCollectionViewCell {
        cell.updateCellImage(displaying: image)
      }
    }
  }
}

