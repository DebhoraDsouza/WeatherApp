//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Debhora D Souza on 17/11/20.
//

import UIKit
import MapKit


class SearchViewController: BaseViewController, MapViewDelegate {
    
    var resultSearchController:UISearchController? = nil
    var searchViewModel = SearchMapViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        
      

        // Do any additional setup after loading the view.
        self.setSearchVC()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setSearchVC(){
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        let controller = MapTableViewController(nibName: "MapTableViewController", bundle: nil)
        controller.searchViewModel = self.searchViewModel
        controller.delegate = self
        resultSearchController = UISearchController(searchResultsController: controller)
        resultSearchController?.searchResultsUpdater = self.searchViewModel
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
    }
    
    /*Show weather view controller*/
    private func showWeatherVC(mapItem:MKMapItem){
        let controller = WeatherViewController(nibName: WeatherViewController.nibName, bundle: nil)
        controller.weatherViewModel.weatherPlace = mapItem
        self.navigationController?.pushViewController(controller, animated: true)

    }
    
    /*Delegate Implementation*/
    func placeSelected(mapItem: MKMapItem) {
        self.showWeatherVC(mapItem: mapItem)
    }
    

}
