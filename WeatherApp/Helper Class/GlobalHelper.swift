//
//  GlobalHelper.swift
//  WeatherApp
//
//  Created by Debhora D Souza on 25/11/20.
//

import Foundation
import UIKit

class GlobalHelper: NSObject {
        override init() {
        super.init()
    }
    
    func getTopViewController () -> BaseViewController? {
        let window = UIApplication.shared.windows.first
        let vc = window?.rootViewController as? UINavigationController
        if (vc?.topViewController?.isKind(of: UIViewController.self)) != nil{
              return vc?.topViewController as? BaseViewController
          }
              return nil
      }

    //same headers added to api calls in future other pparamanter can be added
    func headers()->[String : String]{
        var head = [String:String]()
        head.updateValue("application/json", forKey: "Content-Type")
        head.updateValue("application/json", forKey: "Accept")

        return head
    }



}
