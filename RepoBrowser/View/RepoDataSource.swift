//
//  RepoDataSource.swift
//  RepoBrowser
//
//  Created by malakoipechyva on 7/21/20.
//  Copyright © 2020 malakoipechyva. All rights reserved.
//

import UIKit

class RepoDataSource: NSObject, UICollectionViewDataSource {
  
  var repo = [RepoViewModel]()
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    repo.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let identifier = "RepoCollectionViewCell"
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! RepoCollectionViewCell
    cell.updateCell(displaying: nil, displaying: nil)
    return cell
  }
  
}
