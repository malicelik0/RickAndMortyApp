//
//  LocationCell.swift
//  RickAndMorty
//
//  Created by Mali on 14.04.2023.
//

import UIKit

class LocationCell: UICollectionViewCell {
  let label = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .systemBackground
    layer.cornerRadius = 12
    layer.borderWidth = 2
    layer.borderColor = UIColor.black.cgColor
    
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    label.textColor = .black
    
    contentView.addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
      label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
      label.topAnchor.constraint(equalTo: contentView.topAnchor),
      label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var isSelected: Bool {
    didSet {
      backgroundColor = isSelected ? .systemBlue : .systemBackground
      label.textColor = isSelected ? .black : .black
    }
  }
}

