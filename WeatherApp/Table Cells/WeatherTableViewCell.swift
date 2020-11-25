//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Debhora D Souza on 17/11/20.
//

import UIKit
import MapKit

class WeatherTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(mapItem:MKMapItem){
        self.textLabel?.text = mapItem.name ?? ""
        self.detailTextLabel?.text = self.parseAddress(selectedItem: mapItem.placemark)
    }
    
    
    class var reuseIdentifier: String {
         return "weatherCell"
     }
     class var nibName: String {
         return "WeatherTableViewCell"
     }
    
    private func parseAddress(selectedItem:MKPlacemark) -> String {
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            selectedItem.thoroughfare ?? "",
            comma,
            selectedItem.locality ?? "",
            secondSpace,
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
    
}
