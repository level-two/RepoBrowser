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
  
  func updateCell(displaying image: UIImage?, displaying text: String? ) {
    if let imageToDisplay = image,
      let textToDisplay = text {
      spinner.stopAnimating()
      imageView.image = imageToDisplay
      label.text = textToDisplay
    } else {
      spinner.startAnimating()
      imageView.image = nil
      label.text = ""
    }
  }
}
