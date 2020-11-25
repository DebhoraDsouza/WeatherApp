//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by Debhora D Souza on 17/11/20.
//

import UIKit

typealias JSONDictionary = [String:AnyObject]
typealias JSONArray = [JSONDictionary]

func serializeJsonArray(data:NSData)->[AnyObject]{
    let jsonDictionary : [AnyObject];
    do {
        jsonDictionary = try JSONSerialization.jsonObject(with: data as Data, options:[]) as! [AnyObject]
        
    } catch {
        jsonDictionary = [];
    }
    return jsonDictionary;
    
}

func serializeJson(data: NSData) -> NSDictionary{
    let jsonDictionary : NSDictionary;
    do {
        jsonDictionary = try JSONSerialization.jsonObject(with: data as Data, options:[]) as! NSDictionary
        
    } catch {
        jsonDictionary = [:];
    }
    return jsonDictionary;
}

enum LoaderProcess {
    case IDLE
    case InProgress
    case Done
}
class BaseViewController: UIViewController {
    
    private var mActivityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private  var indicatorView: UIView = UIView()
    private var mLoaderView: LoaderView = LoaderView()
    private var mLoaderProcress = LoaderProcess.IDLE

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*Closures*/
 
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //Error handling in all view controllers
    func handleError(error : ErrorModel){
        let alert: UIAlertController = UIAlertController(title: "", message: error.mErrorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Error", style: .default, handler: { _ in
                 //Cancel Action
             }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func showAlert(title:String, message:String){
        let ac = UIAlertController(title:title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
    }
    func showNewActivityIndicator(color: UIColor, shouldBlockScreen: Bool, message: String = "Please Wait..."){
        
        guard let window = UIApplication.shared.windows.first else{return}
            mLoaderProcress = LoaderProcess.InProgress
            mLoaderView.mLabel.text = message
        mLoaderView.mLabel.isAccessibilityElement = true
            mLoaderView.mLabel.accessibilityLabel = message

            mLoaderView.mActivityIndicator.startAnimating()
            if(shouldBlockScreen){
                UIApplication.shared.inputView?.isUserInteractionEnabled = false
            }
            indicatorView.backgroundColor = color
            indicatorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        indicatorView.center = window.center
            
        window.addSubview(indicatorView)
        UIAccessibility.post(notification: UIAccessibility.Notification.layoutChanged, argument: message)
    }
    
    func hideActivityIndicator(){
       hideNewActivityIndicator(shouldBlockScreen: true)
    }
    
    func hideNewActivityIndicator(shouldBlockScreen: Bool){
            mLoaderProcress = LoaderProcess.Done
            indicatorView.removeFromSuperview()
            if(shouldBlockScreen){
                UIApplication.shared.inputView?.isUserInteractionEnabled = true
            }
        }

}
