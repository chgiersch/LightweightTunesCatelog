//
//  Favorites.swift
//  Lightweight Tunes Catalog
//
//  Created by Christopher Giersch on 4/9/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import Foundation

class Favorites {
  
  var mediaSet: Set<Media>
  
  private let userDefaultsKey = "Favorites"
  private let userDefaults = UserDefaults.standard
  
  
  init() {
    if let data = userDefaults.object(forKey: userDefaultsKey) {
      do {
        let decoder = JSONDecoder()
        mediaSet = try decoder.decode(Set<Media>.self, from: data as! Data)
      } catch {
        print("Error decoding MediaSet from UserDefaults: \(error)")
        mediaSet = []
      }
    } else {
      mediaSet = []
    }
  }
  
  func contains(_ media: Media) -> Bool {
    mediaSet.contains(media)
  }
  
  func add(_ media: Media) {
    mediaSet.insert(media)
    save()
  }
  
  func remove(_ media: Media) {
    mediaSet.remove(media)
    save()
  }
    
  private func save() {
    let defaults = UserDefaults.standard
    do {
      let encoder = JSONEncoder()
      let data = try encoder.encode(self.mediaSet)
      defaults.set(data, forKey: userDefaultsKey)
    } catch {
      print("Error encoding MediaSet to UserDefaults: \(error)")
    }
  }
  
}
