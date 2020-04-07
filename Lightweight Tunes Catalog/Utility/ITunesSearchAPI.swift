//
//  ITunesSearchAPI.swift
//  Lightweight Tunes Catalog
//
//  Created by Christopher Giersch on 4/6/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import Foundation

public class ITunesSearchAPI {
    
  let baseURLString = "https://itunes.apple.com/search?"
  
  public func getMediaResults(withString searchString: String,
                              completion: @escaping (_ searchResults: SearchResults?, _ error: Error?) -> Void) {
    
    let url = URL(string: baseURLString + searchString.urlEncodedTermString())
    get(withURL: url!) { (json, response, error) in
      guard let json = json, error == nil else {
        print("Failed getting data from server")
        return completion(nil, error)
      }
      
      self.createSearchResults(withJSON: json) { (searchResults, error) in
        if let error = error {
          print("Failed to parse json into SearchResults")
          return completion(nil, error)
        }
        return completion(searchResults, error)
      }
    }
  }
  
}


extension ITunesSearchAPI {
  
  private func createSearchResults(withJSON json: Data,
                                   completion: @escaping (_ data: SearchResults?, _ error: Error?) -> Void) {
    do {
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      
      let searchResults = try decoder.decode(SearchResults.self, from: json)
      
      completion(searchResults, nil)
    } catch let error {
      print("Error creating search results media objects from JSON because: \(error.localizedDescription)")
      return completion(nil, error)
    }
  }
  
  private func get(withURL url: URL,
                   completion: @escaping (_ json: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
    
    let request = requestWithHeaders(withUrl: url)
    URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
      guard data != nil else {
        print("No data Found: \(error!)")
        completion(nil, response, error)
        return
      }
      guard error == nil else {
        print("Error calling iTunes Search API")
        completion(nil, response, error)
        return
      }
      
      /// Successful Search!!!
      completion(data, response, nil)
    }.resume()
  }
  
  
  // MARK: - Helpers
  private func requestWithHeaders(withUrl url: URL) -> URLRequest {
    var request = URLRequest(url: url)
    
    request.timeoutInterval = 10
    
    return request
  }
  
}
