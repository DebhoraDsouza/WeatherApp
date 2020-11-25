//
//  IntegreExtension.swift
//  WeatherApp
//
//  Created by Debhora D Souza on 25/11/20.
//

import Foundation

extension Int64{
func getDateFromMilli()->NSDate{
    return NSDate(timeIntervalSince1970: TimeInterval(self))

}

func getTodayWeekDay()-> String{
        let date = getDateFromMilli()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "EEEE"
        let weekDay = dateFormatter.string(from: date as Date)
        return weekDay
  }
}
