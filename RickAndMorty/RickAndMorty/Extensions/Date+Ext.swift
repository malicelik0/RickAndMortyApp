//
//  Date+Ext.swift
//  RickAndMorty
//
//  Created by Mali on 24.04.2023.
//

import Foundation

extension Date {
  
  func convertToFullDateFormat() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d MMM yyyy, HH:mm:ss"
    
    return dateFormatter.string(from: self)
  }
}
