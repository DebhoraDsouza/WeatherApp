//
//  ImageExtension.swift
//  WeatherApp
//
//  Created by Debhora D Souza on 25/11/20.
//

import UIKit

extension UIImageView {
  func loadImage(at url: URL) {
    UIImageLoader.loader.load(url, for: self)
  }

  func cancelImageLoad() {
    UIImageLoader.loader.cancel(for: self)
  }
}
