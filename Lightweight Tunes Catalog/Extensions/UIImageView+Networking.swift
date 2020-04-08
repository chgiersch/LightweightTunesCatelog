//
//  UIImageView+Networking.swift
//  Lightweight Tunes Catalog
//
//  Created by Christopher Giersch on 4/7/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
  func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit, completion: @escaping (_ error: Error?) -> Void) {
    
    let testUrl = URL(string: "https://p1.hiclipart.com/preview/594/586/554/web0-2ama-gray-music-icon-png-clipart.jpg")

    URLSession.shared.dataTask(with: testUrl!) { data, response, error in
      guard
        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
        let data = data, error == nil,
        let image = UIImage(data: data)
        else {
          print("Error downloading image from URL")
          return completion(error)
      }
      DispatchQueue.main.async() {
        self.image = image
      }
      completion(nil)
    }.resume()
  }
  
}
