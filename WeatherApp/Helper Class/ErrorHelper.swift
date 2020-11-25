//
//  ErrorHelper.swift
//  WeatherApp
//
//  Created by Debhora D Souza on 25/11/20.
//

import Foundation

class ErrorHelper: NSObject {
    

    override init() {
        super.init()
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
    
func getDefaultError() -> NSError {
        let error = NSError(domain: Constants.ERROR_MESSAGE, code: Constants.DEFAULT_ERROR_CODE, userInfo: nil)
        return error
}


}
