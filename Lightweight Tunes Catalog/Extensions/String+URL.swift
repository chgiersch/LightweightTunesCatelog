//
//  String+URL.swift
//  Lightweight Tunes Catalog
//
//  Created by Christopher Giersch on 4/6/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import Foundation

extension String {
  
  func urlEncodedTermString() -> String {
    //    var urlEncodedString = ""
    //    let wordArray = string?.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")
    
    let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
    let encodedString = "term=" + trimmedString.replacingOccurrences(of: " ", with: "+")
   
    return encodedString
  }
  
}
