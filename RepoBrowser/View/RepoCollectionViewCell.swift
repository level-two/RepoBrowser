//
//  RepoCollectionViewCell.swift
//  RepoBrowser
//
//  Created by malakoipechyva on 7/21/20.
//  Copyright © 2020 malakoipechyva. All rights reserved.
//

import UIKit

class RepoCollectionViewCell: UICollectionViewCell {
    
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  @IBOutlet weak var label: UILabel!
 
  
  func updateCellImage(displaying image: UIImage?) {
    if let imageToDisplay = image {
      spinner.stopAnimating()
      imageView.image = imageToDisplay
    } else {
      spinner.startAnimating()
      imageView.image = nil
    }
  }
}
