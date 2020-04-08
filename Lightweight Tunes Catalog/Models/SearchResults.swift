//
//  SearchResults.swift
//  Lightweight Tunes Catalog
//
//  Created by Christopher Giersch on 4/7/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import Foundation

public struct SearchResults: Codable {
//  let book: [Media]?
//  let album: [Media]?
//  let coachedAudio: [Media]?
//  let featureMovie: [Media]?
//  let interactiveBooklet: [Media]?
//  let musicVideo: [Media]?
//  let pdf: [Media]?
//  let podcast: [Media]?
//  let podcastEpisode: [Media]?
//  let softwarePackage: [Media]?
//  let song: [Media]?
//  let tvEpisode: [Media]?
//  let artist: [Media]?
  
  let results: [Media]?
//  let resultCount: Int?
  
//  public init(from array: [KeyValuePairs<Any, Any>]) {
//    book = [Media]()
//    album = [Media]()
//    coachedAudio = [Media]()
//    featureMovie = [Media]()
//    interactiveBooklet = [Media]()
//    musicVideo = [Media]()
//    pdf = [Media]()
//    podcast = [Media]()
//    podcastEpisode = [Media]()
//    softwarePackage = [Media]()
//    song = [Media]()
//    tvEpisode = [Media]()
//    artist = [Media]()
//
//    results = [Media]()
//
//    if let dictionary = Dictionary(grouping: results!, by: { $0.kind }) as? [String : [Media]?] {
//      resultsDictionary = dictionary
//      print(resultsDictionary)
//    }
//  }
  
  
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
