//
//  WeatherNetworkService.swift
//  WeatherApp
//
//  Created by Debhora D Souza on 18/11/20.
//



import UIKit
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

class WeatherNetworkService: NSObject {
    
     private var mDisposableBag: DisposeBag  = DisposeBag()
    private var errorHelper=ErrorHelper()


    func getWeatherDetails(url: String, completion: @escaping ([daily]?, ErrorModel?) -> ()){
        
        let observable = APIManager().getResponseFromServer(url: url, requestMethod: .get, httpBody: nil).observeOn(MainScheduler.instance).subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
        
        let subscription  = observable.subscribe{
            event in
            switch event{
            case .completed:
                
                break
            case .next(let value):
                do{
                    let jsonString = NSString(data: value, encoding:String.Encoding.utf8.rawValue) as String? ?? ""
                    let jsonData: NSData = jsonString.data(using: String.Encoding.utf8)! as NSData
                    let data = serializeJson(data: jsonData)
                    let curData = data["daily"] as? [Any] ?? []
                    if curData.count > 0{
                    do {
                        let json = try JSONSerialization.data(withJSONObject: curData)
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let weatherArray = try decoder.decode([daily].self, from: json)
                        completion(weatherArray, nil)
                    } catch _ {
                        let defaultError = self.errorHelper.getDefaultError()
                            let errorModel: ErrorModel = ErrorModel(errorCode: defaultError.code, errorMessage: defaultError.domain)
                            completion(nil, errorModel)
                    }
                }
            }
                break
            case .error(let error):
                let nsError: NSError =  error as NSError
                let errorModel: ErrorModel = ErrorModel(errorCode: nsError.code, errorMessage: nsError.domain)
                completion(nil, errorModel)
                break
            }
        }
        
        subscription.disposed(by: mDisposableBag)
        
    }
}
