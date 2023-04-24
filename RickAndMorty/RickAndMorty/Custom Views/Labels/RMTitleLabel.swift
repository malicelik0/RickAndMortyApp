//
//  RMTitleLabel.swift
//  RickAndMorty
//
//  Created by Mali on 24.04.2023.
//

import UIKit

class RMTitleLabel: UILabel {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure(fontName: nil, fontSize: 20)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(textAlignment: NSTextAlignment, fontName: String? = nil, fontSize: CGFloat = 20) {
    super.init(frame: .zero)
    self.textAlignment = textAlignment
    configure(fontName: fontName, fontSize: fontSize)
  }
  
  private func configure(fontName: String?, fontSize: CGFloat) {
    textColor = .label
    if let fontName = fontName {
      font = UIFont(name: fontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .bold)
    } else {
      font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    adjustsFontSizeToFitWidth = true
    minimumScaleFactor = 0.8
    lineBreakMode = .byTruncatingTail
    translatesAutoresizingMaskIntoConstraints = false
  }
}
