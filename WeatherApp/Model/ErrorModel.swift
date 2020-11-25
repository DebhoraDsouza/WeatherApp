//
//  ErrorModel.swift
//  WeatherApp
//
//  Created by Debhora D Souza on 17/11/20.
//

import Foundation
struct ErrorModel: Error {
    var mErrorCode: Int
    var mErrorMessage: String
    
    init(errorCode: Int, errorMessage: String) {
        self.mErrorCode = errorCode
        self.mErrorMessage = errorMessage
    }
}
