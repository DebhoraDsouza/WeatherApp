//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Debhora D Souza on 17/11/20.
//

import Foundation
import MapKit
import Highcharts

enum TempType:String{
    case min
    case max
}

class WeatherViewModel: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var setErrorModel:((_ errorModel:ErrorModel)->Void)?
    var showActivity:(()->Void)?
    var hideActivity:(()->Void)?
    var loadWeatherDetails:(()->Void)?
    
    var weatherPlace:MKMapItem?
    private var weatherDetails:[daily]?
    private let SECTION_HEIGHT:CGFloat = 86.0
    private var weatherNetworkService = WeatherNetworkService()
    override init() {
        super.init()
    }
    
    func getWeatherDetails(){
        
        guard let city = weatherPlace?.placemark.coordinate else {
            return
        }
        let  weatherUrl = "\(Constants.WEATHER_API)?lat=\(city.latitude)&lon=\(city.longitude)&exclude=hourly&units=metric&appid=\(Constants.WEATHER_API_KEY)"
        self.showActivity?()
        self.weatherNetworkService.getWeatherDetails(url: weatherUrl, completion:{ (weatherArray, errorModel) in
            self.hideActivity?()
            if let curerrorModel = errorModel{
                self.setErrorModel?(curerrorModel)
               return
            }
            if let curWeatherArray = weatherArray{
                self.weatherDetails = curWeatherArray
                self.loadWeatherDetails?()
                return
            }
            
        })
    }
    
    /*Delegate and Datasource*/

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weatherDetails?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if weatherDetails?.count ?? 0 > 0{

       if let cell = collectionView.dequeueReusableCell(withReuseIdentifier:WeatherCollectionViewCell.reuseIdentifier,
                            for: indexPath) as? WeatherCollectionViewCell {
        guard let weather = self.weatherDetails?[indexPath.row] else {return UICollectionViewCell()}
        cell.configureCell(weather: weather)
        return cell
       }
    }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if weatherDetails?.count ?? 0 > 0{

            let noOfCellsInRow = 3
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow + 1) )

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
            return CGSize(width: size, height:116)

        }else{
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                          viewForSupplementaryElementOfKind kind: String,
                          at indexPath: IndexPath) -> UICollectionReusableView {

          switch kind {

          case UICollectionView.elementKindSectionHeader:
             if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SingleCollectionReusableView.identifier, for: indexPath) as? SingleCollectionReusableView{
                headerView.headerTitle.text = "Weather for next \(self.weatherDetails?.count ?? 0) days (°Celsius)"
                
                      return headerView
              }

              return UICollectionReusableView()
          default:
              assert(false, "Unexpected element kind")
          }
      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
      return CGSize(width: collectionView.frame.width, height: self.SECTION_HEIGHT)
    }
  
    
    
    /*HiCharts perform logic and assign to View*/
    
    func getHiChartOption()->HIOptions{
        let options = HIOptions()
        let title = HITitle()
        title.text = "Weather Forecast"

        let subtitle = HISubtitle()
        subtitle.text = "Weekly Statistics"
        options.title = title
        options.subtitle = subtitle
        
        let xAxis = HIXAxis()
        options.xAxis = [xAxis]
        xAxis.min = 0

        let yAxis = HIYAxis()
        yAxis.min = -10.0
        yAxis.title = HITitle()
        yAxis.title.text = "Temperature"
        options.yAxis = [yAxis]
        
        let plotOptions = HIPlotOptions()
        plotOptions.column = HIColumn()
        plotOptions.column.pointPadding = 0.2
        plotOptions.column.borderWidth = 0
        options.plotOptions = plotOptions

        options.plotOptions = plotOptions
        
        let minLine = getHiChartLine(tempType: .min)
        let maxLine = getHiChartLine(tempType: .max)
        
        options.series = [minLine, maxLine]
        return options
    }
    
    private func getHiChartLine(tempType:TempType)->HILine{
        let curLine = HILine()
        switch tempType {
        case .min:
            curLine.name = "Min Temperature in Celsius"
            curLine.data =  self.weatherDetails?.map({$0.temp?.min}) as? [Double] ?? [Double]()
            break
        case .max:
            curLine.name = "Max Temperature in Celsius"
            curLine.data =  self.weatherDetails?.map({$0.temp?.max}) as? [Double] ?? [Double]()
            break
        }
       return curLine
    }
    
    


}
