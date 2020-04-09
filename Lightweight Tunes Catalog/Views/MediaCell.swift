//
//  MediaCell.swift
//  Lightweight Tunes Catalog
//
//  Created by Christopher Giersch on 4/7/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import UIKit

class MediaCell: UITableViewCell {
  
  @IBOutlet weak var artworkImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var favoriteButton: UIButton!
  var favorites: Favorites?
  var media: Media? {
    didSet {
      setupView()
    }
  }
  
  
  override func prepareForReuse()  {
    setupView()
  }
  
  func setupView() {
    nameLabel.text = media?.name
    genreLabel.text = media?.genre
    
    if let artworkURL = media?.url {
      artworkImageView.downloaded(from: URL(string: artworkURL)!) { (error) in
        if error != nil {
          let placeholderURL = URL(string: "https://p1.hiclipart.com/preview/594/586/554/web0-2ama-gray-music-icon-png-clipart.jpg")
          
          self.artworkImageView.downloaded(from: placeholderURL!) { (error) in
            print("Placeholder image failed to download TOO!!! NOOOOOO!")
          }
        }
      }
    }
  }
  
  
  
  @IBAction func didTapFavoriteButton(_ sender: Any) {
    if self.favorites?.contains(media!) ?? false {
      self.favorites?.remove(media!)
      self.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
    } else {
      self.favorites?.add(media!)
      self.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
  }
  
}
