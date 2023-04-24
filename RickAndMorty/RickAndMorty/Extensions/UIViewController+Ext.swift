//
//  UIViewController+Ext.swift
//  RickAndMorty
//
//  Created by Mali on 24.04.2023.
//

import UIKit

extension UIViewController {
  
  func presentRMAlertOnMainThread(title: String, message: String, buttonTitle: String) {
    DispatchQueue.main.async {
      let alertVC = RMAlertVC(title: title, message: message, buttonTitle: buttonTitle)
      alertVC.modalPresentationStyle = .overFullScreen
      alertVC.modalTransitionStyle = .crossDissolve
      self.present(alertVC, animated: true)
    }
  }
}
