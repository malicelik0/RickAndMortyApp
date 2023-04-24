//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Mali on 14.04.2023.
//

import UIKit

class NetworkManager {
  static let shared = NetworkManager()
  private let baseURL = "https://rickandmortyapi.com/api/"
  
  func getLocations(page: Int, completed: @escaping (Result<[Location], RMError>) -> Void) {
    let endpoint = baseURL + "location?page=\(page)"
    
    guard let url = URL(string: endpoint) else {
      completed(.failure(.unableToComplete))
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      
      if let _ = error {
        completed(.failure(.unableToComplete))
        return
      }
      
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        completed(.failure(.invalidResponse))
        return
      }
      
      guard let data = data else {
        completed(.failure(.invalidData))
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let locationResponse = try decoder.decode(LocationResponse.self, from: data)
        let locations = locationResponse.results
        completed(.success(locations))
      } catch {
        completed(.failure(.invalidData))
      }
    }
    
    task.resume()
  }
  
  func getCharacters(residentIDs: [Int], completed: @escaping (Result<[Character], RMError>) -> Void) {
    let residentIDStrings = residentIDs.map { String($0) }
    let endpoint = baseURL + "character/" + residentIDStrings.joined(separator: ",")
    
    guard let url = URL(string: endpoint) else {
      completed(.failure(.unableToComplete))
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let _ = error {
        completed(.failure(.unableToComplete))
        return
      }
      
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        completed(.failure(.invalidResponse))
        return
      }
      
      guard let data = data else {
        completed(.failure(.invalidData))
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let charactersResponse = try decoder.decode([Character].self, from: data)
        completed(.success(charactersResponse))
      } catch {
        completed(.failure(.invalidData))
      }
    }
    
    task.resume()
  }
  
  func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let data = data, let image = UIImage(data: data) {
        completion(image)
      } else {
        completion(nil)
      }
    }
    task.resume()
  }
}
