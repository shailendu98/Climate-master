//
//  WeatherModel2.swift
//  Climate
//
//  Created by Shailendu on 20/05/24.
//

import Foundation
struct WeatherModel {
    var conditionid:Int
    var cityname:String
    var temp:Double
    var conditionName:String{
        switch conditionid {
       
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud.bolt"
                default:
                    return "cloud"
                }
    }
    var tempString :String{
        return String(format: "%.1f", temp)
    }
    
    
    
    
}
