//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Mali on 14.04.2023.
//

import UIKit

class CharacterCell: UITableViewCell {
  
  let placeholderImage = UIImage(named: "rmLaunch")!
  
  let cellImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  let genderImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  let cellLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    cellImageView.image = placeholderImage
    setupSubviews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with character: Character) {
    cellLabel.text = character.name
    
    switch character.gender {
    case .male:
      setBackgroundImage(named: "male")
    case .female:
      setBackgroundImage(named: "female")
    case .unknown:
      setBackgroundImage(named: "unknown")
    }
  }
  
  private func setBackgroundImage(named imageName: String) {
    if let backgroundImage = UIImage(named: imageName) {
      let backgroundImageView = UIImageView(image: backgroundImage)
      backgroundImageView.contentMode = .right
      backgroundImageView.clipsToBounds = true
      backgroundImageView.alpha = 0.7
      self.backgroundView = backgroundImageView
    }
  }
  
  private func setupSubviews() {
    addSubview(cellImageView)
    addSubview(cellLabel)
    let padding: CGFloat = 10
    NSLayoutConstraint.activate([
      cellImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      cellImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
      cellImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
      cellImageView.widthAnchor.constraint(equalToConstant: 90),
      cellImageView.heightAnchor.constraint(equalToConstant: 90),
      
      cellLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 25),
      cellLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      cellLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
      
    ])
  }
  
  
}
