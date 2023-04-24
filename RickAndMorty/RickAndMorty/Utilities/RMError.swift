//
//  RMError.swift
//  RickAndMorty
//
//  Created by Mali on 14.04.2023.
//

import Foundation

enum RMError: String, Error {
  case unableToComplete = "Unable to complete request. Please check your internet connection."
  case invalidResponse = "Invalid response from the server. Please try again."
  case invalidData = "The data received from the server was invalid. Please try again."
  
}
