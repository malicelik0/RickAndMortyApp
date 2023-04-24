//
//  Models.swift
//  RickAndMorty
//
//  Created by Mali on 14.04.2023.
//

import Foundation


struct LocationResponse: Codable {
  let info: PageInfo
  let results: [Location]
}

struct PageInfo: Codable {
  let count: Int
  let pages: Int
  let next: String?
  let prev: String?
}

struct Location: Codable {
  let id: Int
  let name: String
  let type: String
  let dimension: String
  let residents: [String]
  let url: String
  let created: String
  
  var residentIDs: [Int] {
    return residents.compactMap { URL(string: $0)?.lastPathComponent }.compactMap(Int.init)
  }
  
}

struct Character: Codable {
  let id: Int
  let name: String
  let status: String
  let species: String
  let type: String
  let gender: Gender
  let origin: PartialLocation
  let location: PartialLocation
  let image: String
  let episode: [String]
  let url: String
  let created: String
  
  var episodesNames: [Int] {
    return episode.compactMap { URL(string: $0)?.lastPathComponent }.compactMap(Int.init)
  }
}

enum Gender: String, Codable {
  case male = "Male"
  case female = "Female"
  case unknown = "unknown"
}

struct PartialLocation: Codable {
  let name: String
  let url: String
}
