//
//  DetailVC.swift
//  RickAndMorty
//
//  Created by Mali on 23.04.2023.
//

import UIKit

class DetailVC: UIViewController {
  
  var character: Character?
  
  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()
  
  private let contentView: UIView = {
    let contentView = UIView()
    contentView.translatesAutoresizingMaskIntoConstraints = false
    return contentView
  }()
  
  private let characterImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  let statusTitle = RMTitleLabel(textAlignment: .center, fontName: "Avenir", fontSize: 22)
  let specyTitle = RMTitleLabel(textAlignment: .center, fontName: "Avenir", fontSize: 22)
  let genderTitle = RMTitleLabel(textAlignment: .center, fontName: "Avenir", fontSize: 22)
  let originTitle = RMTitleLabel(textAlignment: .center, fontName: "Avenir", fontSize: 22)
  let locationTitle = RMTitleLabel(textAlignment: .center, fontName: "Avenir", fontSize: 22)
  let episodesTitle = RMTitleLabel(textAlignment: .center, fontName: "Avenir", fontSize: 22)
  let createdTitle = RMTitleLabel(textAlignment: .center, fontName: "Avenir", fontSize: 22)
  
  let statusLabel = RMBodyLabel(textAlignment: .left,fontName: "Avenir", fontSize: 22)
  let specyLabel = RMBodyLabel(textAlignment: .left,fontName: "Avenir", fontSize: 22)
  let genderLabel = RMBodyLabel(textAlignment: .left,fontName: "Avenir", fontSize: 22)
  let originLabel = RMBodyLabel(textAlignment: .left,fontName: "Avenir", fontSize: 22)
  let locationLabel = RMBodyLabel(textAlignment: .left,fontName: "Avenir", fontSize: 22)
  let episodesLabel = RMBodyLabel(textAlignment: .left,fontName: "Avenir", fontSize: 22)
  let createdLabel = RMBodyLabel(textAlignment: .left,fontName: "Avenir", fontSize: 22)
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    configureScrollView()
    configureContentView()
    configureViews()
    
    if let character = character {
      navigationItem.title = character.name
      
      if let imageUrl = URL(string: character.image) {
        NetworkManager.shared.loadImage(from: imageUrl) { [weak self] (image) in
          DispatchQueue.main.async {
            self?.characterImage.image = image
          }
        }
        statusTitle.text = "Status: "
        specyTitle.text = "Spacy: "
        genderTitle.text = "Gender: "
        originTitle.text = "Origin: "
        locationTitle.text = "Location: "
        episodesTitle.text = "Episodes: "
        createdTitle.numberOfLines = 0
        createdTitle.text = "Created at\n(in API): "
        
        statusLabel.text = character.status
        specyLabel.text = character.species
        genderLabel.text = character.gender.rawValue
        originLabel.text = character.origin.name
        locationLabel.text = character.location.name
        let episodesNamesString = character.episodesNames.map { String($0) }
        episodesLabel.text = episodesNamesString.joined(separator: ", ")
        createdLabel.text = character.created.convertToDisplayFormat()
      }
    }
  }
  
  private func configureScrollView() {
    view.addSubview(scrollView)
    
    NSLayoutConstraint.activate([
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    ])
  }
  
  private func configureContentView() {
    scrollView.addSubview(contentView)
    
    NSLayoutConstraint.activate([
      contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
    ])
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    updateContentViewHeight()
  }
  
  private func updateContentViewHeight() {
    let contentViewHeight = createdLabel.frame.maxY + 20
    contentView.frame.size.height = contentViewHeight
    scrollView.contentSize.height = contentViewHeight
  }
  
  private func configureViews() {
    contentView.addSubview(characterImage)
    
    contentView.addSubview(statusTitle)
    contentView.addSubview(specyTitle)
    contentView.addSubview(genderTitle)
    contentView.addSubview(originTitle)
    contentView.addSubview(locationTitle)
    contentView.addSubview(episodesTitle)
    contentView.addSubview(createdTitle)
    
    contentView.addSubview(statusLabel)
    contentView.addSubview(specyLabel)
    contentView.addSubview(genderLabel)
    contentView.addSubview(originLabel)
    contentView.addSubview(locationLabel)
    contentView.addSubview(episodesLabel)
    contentView.addSubview(createdLabel)
    
    let padding: CGFloat = 20
    let labelSpacing: CGFloat = 5
    
    NSLayoutConstraint.activate([
      characterImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: padding),
      characterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
      characterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
      characterImage.heightAnchor.constraint(equalToConstant: 275),
      characterImage.widthAnchor.constraint(equalToConstant: 275),
      
      statusTitle.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: padding),
      statusTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      
      statusLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: padding),
      statusLabel.leadingAnchor.constraint(equalTo: statusTitle.trailingAnchor, constant: padding),
      statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
      
      
      specyTitle.topAnchor.constraint(equalTo: statusTitle.bottomAnchor, constant: labelSpacing),
      specyTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      
      specyLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: labelSpacing),
      specyLabel.leadingAnchor.constraint(equalTo: specyTitle.trailingAnchor, constant: padding),
      specyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
      
      
      genderTitle.topAnchor.constraint(equalTo: specyTitle.bottomAnchor, constant: labelSpacing),
      genderTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      
      genderLabel.topAnchor.constraint(equalTo: specyLabel.bottomAnchor, constant: labelSpacing),
      genderLabel.leadingAnchor.constraint(equalTo: genderTitle.trailingAnchor, constant: padding),
      genderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
      
      
      originTitle.topAnchor.constraint(equalTo: genderTitle.bottomAnchor, constant: labelSpacing),
      originTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      
      originLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: labelSpacing),
      originLabel.leadingAnchor.constraint(equalTo: originTitle.trailingAnchor, constant: padding),
      originLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
      
      
      locationTitle.topAnchor.constraint(equalTo: originTitle.bottomAnchor, constant: labelSpacing),
      locationTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      
      locationLabel.topAnchor.constraint(equalTo: originLabel.bottomAnchor, constant: labelSpacing),
      locationLabel.leadingAnchor.constraint(equalTo: locationTitle.trailingAnchor, constant: padding),
      locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
      
      
      episodesTitle.topAnchor.constraint(equalTo: locationTitle.bottomAnchor, constant: labelSpacing),
      episodesTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      
      episodesLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: labelSpacing),
      episodesLabel.leadingAnchor.constraint(equalTo: episodesTitle.trailingAnchor, constant: padding),
      episodesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
      
      
      createdTitle.topAnchor.constraint(equalTo: episodesTitle.bottomAnchor, constant: labelSpacing),
      createdTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      createdTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
      
      createdLabel.topAnchor.constraint(equalTo: episodesLabel.bottomAnchor, constant: labelSpacing),
      createdLabel.leadingAnchor.constraint(equalTo: createdTitle.trailingAnchor, constant: padding),
      createdLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
      createdLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
    ])
  }
}
