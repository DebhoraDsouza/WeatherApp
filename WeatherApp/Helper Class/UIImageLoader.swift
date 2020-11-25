//
//  UIImageLoader.swift
//  WeatherApp
//
//  Created by Debhora D Souza on 25/11/20.
//

import UIKit

class UIImageLoader: NSObject {
    
    static let loader = UIImageLoader()

    private let imageLoader = ImageLoader()
    private var uuidMap = [UIImageView: UUID]()

    private override init() {}

    func load(_ url: URL, for imageView: UIImageView) {
      let token = imageLoader.loadImage(url) { result in
        defer { self.uuidMap.removeValue(forKey: imageView) }
        do {
          let image = try result.get()
          DispatchQueue.main.async {
            imageView.image = image
          }
        } catch {
            print("Unable to download image")
        }
      }

      if let token = token {
        uuidMap[imageView] = token
      }
    }

      func cancel(for imageView: UIImageView) {
        if let uuid = uuidMap[imageView] {
            imageLoader.cancelLoad(uuid)
            uuidMap.removeValue(forKey: imageView)
          }
      }

}
