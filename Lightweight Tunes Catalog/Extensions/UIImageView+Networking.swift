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
    
    URLSession.shared.dataTask(with: url) { data, response, error in
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
