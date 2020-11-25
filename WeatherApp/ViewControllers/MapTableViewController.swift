//
//  MapTableViewController.swift
//  WeatherApp
//
//  Created by Debhora D Souza on 17/11/20.
//

import UIKit
import MapKit

protocol MapViewDelegate {
    func placeSelected(mapItem:MKMapItem)
}


class MapTableViewController: UITableViewController {

    var searchViewModel:SearchMapViewModel?

    var delegate:MapViewDelegate?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableview()


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        /*Implement Closures*/
        self.searchViewModel?.reloadMapTable = { (matchingItems) in
            self.tableView.reloadData()
        }
        

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.searchViewModel?.matchingItems.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:WeatherTableViewCell.reuseIdentifier) as? WeatherTableViewCell else {return UITableViewCell()}
        guard let selectedItem = searchViewModel?.matchingItems[indexPath.row] else {return UITableViewCell()}
        cell.configureCell(mapItem: selectedItem)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let selectedItem = searchViewModel?.matchingItems[indexPath.row] else {return}
        self.delegate?.placeSelected(mapItem: selectedItem)
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func setUpTableview(){
        self.tableView.register(UINib(nibName:WeatherTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: WeatherTableViewCell.reuseIdentifier)
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.clipsToBounds = true
    }
    

    
    
}

