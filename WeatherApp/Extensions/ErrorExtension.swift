//
//  ErrorExtension.swift
//  WeatherApp
//
//  Created by Debhora D Souza on 25/11/20.
//

import Foundation


extension Error{
    func handleTimeOutError(){
        if  let vc = GlobalHelper().getTopViewController(){
            let nsError: NSError =  self as NSError
            let errorModel: ErrorModel = ErrorModel(errorCode:nsError.code , errorMessage:nsError.localizedDescription )
            vc.handleError(error: errorModel)
            return
        }
    }



    func createError(){
        let nsError: NSError =  self as NSError
        let errorModel: ErrorModel = ErrorModel(errorCode: nsError.code , errorMessage: nsError.domain)
        guard let vc = GlobalHelper().getTopViewController() else {return}
        vc.handleError(error: errorModel)
    }

}
