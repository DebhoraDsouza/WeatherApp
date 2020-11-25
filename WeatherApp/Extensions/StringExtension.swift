//
//  StringExtension.swift
//  WeatherApp
//
//  Created by Debhora D Souza on 25/11/20.
//

import Foundation


extension String{
    func getImageUrl(with icon:String, extn:String)->URL?{
        let imageUrl =  URL(string: "\(self)\(icon).\(extn)")
        return imageUrl
    }
}
