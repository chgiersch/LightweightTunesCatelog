//
//  SearchResults.swift
//  Lightweight Tunes Catalog
//
//  Created by Christopher Giersch on 4/7/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import Foundation

public struct SearchResults: Codable {
  
  let results: [Media]?
  
  
  enum MediaType: String {
    case album
    case artist
    case book
    case coachedAudio
    case featureMovie
    case interactiveBooklet
    case musicVideo
    case pdf
    case podcast
    case podcastEpisode
    case softwarePackage
    case song
    case tvEpisode
  }
}
