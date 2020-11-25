//
//  WeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Debhora D Souza on 18/11/20.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(weather:daily){
        if let weatherTemp = weather.temp?.min , let icon = weather.weather?.first?.icon, let date = weather.dt{
            self.tempLabel.text = String(format:"%.2f",weatherTemp)
            if let url = Constants.WEATHER_IMAGE_URL.getImageUrl(with: icon, extn: "png") {
                self.weatherImageView.loadImage(at: url)
            }else{
                self.weatherImageView.image = UIImage(named: "weather_placeholder")
            }
            self.dayLabel.text = date.getTodayWeekDay()
        }
    }
    
    private func loadImage(urlStr:String){
        guard let url = URL(string: urlStr)else{
          return
        }
        DispatchQueue.global().async {
            do{
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.weatherImageView.image = UIImage(data: data )
                }
            }catch {
                //set to default image
                return
            }
        }
    }

    override func prepareForReuse() {
        weatherImageView.image = nil
        weatherImageView.cancelImageLoad()
    }


    
    
    class var reuseIdentifier: String {
         return "dailyWeatherCell"
     }
     class var nibName: String {
         return "WeatherCollectionViewCell"
     }


}
