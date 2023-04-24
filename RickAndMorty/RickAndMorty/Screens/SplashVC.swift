//
//  SplashVC.swift
//  RickAndMorty
//
//  Created by Mali on 14.04.2023.
//

import UIKit

class SplashVC: UIViewController {
  
  let myLabel = UILabel()
  let myAvatar = UIImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setSplash()
  }
  
  private func setSplash() {
    view.addSubview(myLabel)
    view.addSubview(myAvatar)
    
    myAvatar.image = UIImage(named: "rmLaunch")
    
    myLabel.translatesAutoresizingMaskIntoConstraints = false
    myAvatar.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      myAvatar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      myAvatar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      myAvatar.heightAnchor.constraint(equalToConstant: 300),
      myAvatar.widthAnchor.constraint(equalToConstant: 300),
      
      myLabel.topAnchor.constraint(equalTo: myAvatar.bottomAnchor, constant: 10),
      myLabel.centerXAnchor.constraint(equalTo: myAvatar.centerXAnchor),
      myLabel.heightAnchor.constraint(equalToConstant: 30)
    ])
  }
}
