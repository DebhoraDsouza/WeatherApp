//
//  APIManager.swift
//  WeatherApp
//
//  Created by Debhora D Souza on 18/11/20.
//

import Foundation
import Alamofire
import RxSwift

class APIManager: SessionDelegate {

    var sessionManager: SessionManager?
    var errorHelper = ErrorHelper()
    
      override init(){
            super.init()
            
        if (sessionManager == nil){
            sessionManager = SessionManager.init(configuration: URLSessionConfiguration.ephemeral, delegate: self)
        }
      }

    
    func getResponseFromServer(url:String, requestMethod:HTTPMethod,httpBody:Data?)->Observable<Data>{
        
        return Observable<Data>.create { observer in
            
            let request = self.getUrlRequestObject(url: url, httpMethod: requestMethod, headers: GlobalHelper().headers(), httpBody: httpBody)
            
            let alamofireRequest = self.sessionManager?.request(request).responseJSON(completionHandler: { response in
                switch response.result {
                case .failure(let error):
                    if let curError = error as? NSError{
                        if curError.code == -1001{
                            error.handleTimeOutError()
                            return
                        }
                    }
                    observer.onError(self.errorHelper.getDefaultError())
                    break
                case .success( _):
                    
                    if(response.response?.statusCode ?? 200 < 300){
                        observer.onNext(response.data ?? Data())
                        observer.onCompleted()
                    }else{
                        observer.onError(self.errorHelper.getServerError(error: response.result.value as AnyObject))
                    }
                    
                    break
                }
            })
            
            return Disposables.create {
                alamofireRequest?.cancel()
            }
        }
    }
    
    
    private func getUrlRequestObject(url:String,httpMethod:HTTPMethod, headers:[String:String]?,httpBody:Data?)->URLRequest
    {
        let urlTOSend=URL.init(string: url)
        var request = URLRequest(url: urlTOSend!)
        request.httpMethod = httpMethod.rawValue
        request.timeoutInterval = Constants.TIMEOUT_INTERVAL_VALUE
        if let headers = headers
        {
            request.allHTTPHeaderFields = headers
        }
        
        request.cachePolicy = .reloadIgnoringCacheData
        
        if let httpBodyData = httpBody
        {
            request.httpBody = httpBodyData
        }
        
        return request
    }
}
