//
//  RMBodyLabel.swift
//  RickAndMorty
//
//  Created by Mali on 24.04.2023.
//

import UIKit

class RMBodyLabel: UILabel {
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure(fontName: nil, fontSize: 17)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(textAlignment: NSTextAlignment, fontName: String? = nil, fontSize: CGFloat = 17) {
    super.init(frame: .zero)
    self.textAlignment = textAlignment
    configure(fontName: fontName, fontSize: fontSize)
  }
  
  private func configure(fontName: String?, fontSize: CGFloat) {
    textColor = .secondaryLabel
    if let fontName = fontName {
      font = UIFont(name: fontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .regular)
    } else {
      font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
    }
    adjustsFontSizeToFitWidth = true
    minimumScaleFactor = 0.75
    translatesAutoresizingMaskIntoConstraints = false
  }
}
