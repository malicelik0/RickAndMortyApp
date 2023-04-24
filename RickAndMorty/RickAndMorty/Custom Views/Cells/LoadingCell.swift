//
//  LoadingCell.swift
//  RickAndMorty
//
//  Created by Mali on 24.04.2023.
//

import UIKit

class LoadingCell: UICollectionViewCell {
  let spinner = UIActivityIndicatorView(style: .medium)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupSpinner()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupSpinner() {
    addSubview(spinner)
    spinner.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
      spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
}
