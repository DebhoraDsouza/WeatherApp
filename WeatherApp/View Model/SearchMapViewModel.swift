//
//  SearchMapViewModel.swift
//  WeatherApp
//
//  Created by Debhora D Souza on 17/11/20.
//

import Foundation
import MapKit

class SearchMapViewModel: NSObject, UISearchResultsUpdating {
    override init() {
        super.init()
    }
    
    /*Closures to implement MVVM*/
    var reloadMapTable:((_ matchingItems:[MKMapItem])->Void)?

    
    var matchingItems = [MKMapItem]()

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else { return }
    let request = MKLocalSearch.Request()
       request.naturalLanguageQuery = searchBarText
       let search = MKLocalSearch(request: request)
        search.start { response, _ in
           guard let response = response else {
               return
           }
           self.matchingItems = response.mapItems
        self.reloadMapTable?(self.matchingItems)
       }
}

    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
            guard let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
           request.naturalLanguageQuery = searchBarText
           let search = MKLocalSearch(request: request)
            search.start { response, _ in
               guard let response = response else {
                   return
               }
               self.matchingItems = response.mapItems
            self.reloadMapTable?(self.matchingItems)
           }
    }
    

}
