//
//  Extension.swift
//  WeatherApp
//
//  Created by Debhora D Souza on 17/11/20.
//

import Foundation
import SwiftyJSON
import UIKit

func createError(error:Error)->Void{
    let nsError: NSError =  error as NSError
    let errorModel: ErrorModel = ErrorModel(errorCode: nsError.code , errorMessage: nsError.domain)
    guard let vc = getTopViewController() else {return}
    vc.handleError(error: errorModel)
}

func getTopViewController () -> BaseViewController? {
    let window = UIApplication.shared.windows.first
    let vc = window?.rootViewController as? UINavigationController
    if (vc?.topViewController?.isKind(of: UIViewController.self)) != nil{
          return vc?.topViewController as? BaseViewController
      }
          return nil
  }

func headers()->[String : String]{
    var head = [String:String]()
    head.updateValue("application/json", forKey: "Content-Type")
    head.updateValue("application/json", forKey: "Accept")

    return head
}

func handleTimeOutError(error:Error){
    if  let vc = getTopViewController(){
        let errorModel: ErrorModel = ErrorModel(errorCode: Constants.DEFAULT_ERROR_CODE, errorMessage: Constants.ERROR_MESSAGE)
        vc.handleError(error: errorModel)
        return
    }
}

func getDefaultError() -> NSError {
        let error = NSError(domain: Constants.ERROR_MESSAGE, code: Constants.DEFAULT_ERROR_CODE, userInfo: nil)
        return error
    }

func getServerError(error: AnyObject) -> NSError {
  
  var serverError: NSError? = nil
  if let errorData  = error as? JSONDictionary{
      let code  = errorData["code"]as? Int ?? Constants.DEFAULT_ERROR_CODE
      let message  = errorData["message"]as? String ?? Constants.ERROR_MESSAGE
      serverError = NSError(domain: message, code: code, userInfo: nil)
  }else{
      serverError = NSError(domain: Constants.ERROR_MESSAGE, code: Constants.DEFAULT_ERROR_CODE, userInfo: nil)
  }
  
  return serverError ?? getDefaultError()
}

func getDateFromMilli(milli:Int64)->NSDate{
    return NSDate(timeIntervalSince1970: TimeInterval(milli))

}


func getTodayWeekDay(milli:Int64)-> String{
        let date = getDateFromMilli(milli: milli)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "EEEE"
        let weekDay = dateFormatter.string(from: date as Date)
        return weekDay
  }



extension Date{
    func getCurrentMillis()->CLongLong {
        return CLongLong(self.timeIntervalSince1970 * 1000)
    }
    


}

