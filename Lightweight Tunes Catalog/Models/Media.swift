//
//  Media.swift
//  Lightweight Tunes Catalog
//
//  Created by Christopher Giersch on 4/6/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import Foundation

public struct Media {
  
  var id: Int? // trackId (ID of entity)
  var name: String? // name of entity
  var artwork: String? // URL of the artwork
  var genre: String? // Genre of entity
  var url: String? // trackViewUrl
}

extension Media: Codable {
  
  enum CodingKeys: String, CodingKey {
    case id = "trackId"
    case name = "trackName"
    case artwork = "artworkUrl60"
    case genre = "primaryGenreName"
    case url = "trackViewUrl"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    
    id = try values.decodeIfPresent(Int.self, forKey: .id)
    name = try values.decodeIfPresent(String.self, forKey: .name)
    artwork = try values.decodeIfPresent(String.self, forKey: .artwork) // I chose artworkUrl60
    genre = try values.decodeIfPresent(String.self, forKey: .genre)
    url = try values.decodeIfPresent(String.self, forKey: .url)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encodeIfPresent(id, forKey: .id)
    try container.encodeIfPresent(name, forKey: .name)
    try container.encodeIfPresent(artwork, forKey: .artwork) // I chose artworkUrl60
    try container.encodeIfPresent(genre, forKey: .genre)
    try container.encodeIfPresent(url, forKey: .url)

  }
}
