//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Debhora D Souza on 17/11/20.
//

import UIKit
import Highcharts

class WeatherViewController: BaseViewController {
    var weatherViewModel = WeatherViewModel()

    @IBOutlet weak var chartView: HIChartView!
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       


        // Do any additional setup after loading the view.
        
        /*Closures*/
        self.weatherViewModel.setErrorModel = { (errorModel) in
            self.handleError(error: errorModel)
        }
        self.weatherViewModel.showActivity = {
            self.showNewActivityIndicator(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25), shouldBlockScreen: true)
        }
        
        self.weatherViewModel.hideActivity = {
            self.hideNewActivityIndicator(shouldBlockScreen: true)
        }
        self.weatherViewModel.loadWeatherDetails = {
            self.weatherCollectionView.reloadData()
            self.setHIOptionsView()

        }
        
        /*Viewcontroller specfic*/
        self.navigationItem.title = "Weather Details"
        self.setUpCollectionView()
        self.weatherViewModel.getWeatherDetails()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
     class var nibName: String {
         return "WeatherViewController"
     }
    
    private func setUpCollectionView(){
        self.weatherCollectionView.register(UINib(nibName:WeatherCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: WeatherCollectionViewCell.reuseIdentifier)
        self.weatherCollectionView.register( SingleCollectionReusableView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:SingleCollectionReusableView.identifier)
        self.weatherCollectionView.dataSource = self.weatherViewModel
        self.weatherCollectionView.delegate = self.weatherViewModel
        
        let margin: CGFloat = 24


        if let flowLayout = self.weatherCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            
            flowLayout.minimumInteritemSpacing = margin
            flowLayout.minimumLineSpacing = margin
            flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
            flowLayout.headerReferenceSize = CGSize(width: self.view.bounds.size.width, height: 40.0)

        }
    }
    
    private func setHIOptionsView(){
        self.chartView.options = self.weatherViewModel.getHiChartOption()
    }


}
