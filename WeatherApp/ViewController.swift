//
//  ViewController.swift
//  WeatherApp
//
//  Created by Debhora D Souza on 17/11/20.
//

import UIKit
import GoogleSignIn
 

class ViewController: BaseViewController {

    let loginViewModel = LoginViewModel()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*closures*/
        self.loginViewModel.showAlert = {(title, message) in
            self.showAlert(title: title, message: message)
        }
        
        self.loginViewModel.showPlaceSearchVC = {
            self.showSearchRegionVC()
        }
        
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
          // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    /* Show next view controller after sign in*/
    private func showSearchRegionVC(){
        
        let controller = SearchViewController(nibName: "SearchViewController", bundle: nil)
        let window = UIApplication.shared.windows.first
         var vc = window?.rootViewController as? UINavigationController
            if vc == nil{
                vc = UINavigationController ()
            }
        vc?.setViewControllers([controller], animated: true)
        window?.rootViewController = vc
    }
    
    
    @IBAction func useTouchIDTapped(_ sender: Any) {
    }


}

