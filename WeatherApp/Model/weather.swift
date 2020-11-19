//
//  weather.swift
//  WeatherApp
//
//  Created by Debhora D Souza on 19/11/20.
//

import Foundation
struct weather: Codable {
    var icon:String?
    var main:String?
    var description:String?
    var id:Int?
}

extension weather {
  init(data: Data) throws {
    self = try JSONDecoder().decode(weather.self, from: data)
  }
  init(_ json: String, using encoding: String.Encoding = .utf8) throws {
    guard let data = json.data(using: encoding) else {
      throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
    }
    try self.init(data: data)
  }
  init(fromURL url: URL) throws {
    try self.init(data: try Data(contentsOf: url))
  }
  func jsonData() throws -> Data {
    return try JSONEncoder().encode(self)
  }
  func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
    return String(data: try self.jsonData(), encoding: encoding)
  }
    
    func jsonDataArray() throws -> Data {
      return try JSONEncoder().encode([self])
    }
}
