//
//  WeatherUrlData.swift
//  Climate
//
//  Created by Shailendu on 19/05/24.
//

import Foundation
protocol WeatherManegerDeligate {
    func didUpdateWeather(_ weathermanager:WeatherUrlData,weather:WeatherModel)
    func didFailwithError(error:Error)
}

struct WeatherUrlData {
   var url = "https://api.openweathermap.org/data/2.5/weather?appid=68b702e20a35f5e73bb93e67bf7201eb&units=metric"
    
    var delegate :WeatherManegerDeligate?
    func getWeatherData(city:String){
        let furl = "\(url)&q=\(city)"
    
      performUrl(with : furl)
    }
    func getWeatherData(latitude:Double,longitude:Double){
        let furl = "\(url)&lat=\(latitude)&lon=\(longitude)"
        performUrl(with: furl)
    }
    func performUrl(with urlString:String){
//        it is of 4 process
//        1.get Url From String
//        2.create urlSession
//        3.given The session a task
//        5.resume task
        if let url = URL( string: urlString){
          
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, responce, error) in
            if let error = error{
                delegate?.didFailwithError(error: error)
            }
            if let safedata = data{
                if let weather = parseJson(safedata){
                    self.delegate?.didUpdateWeather(self,weather:weather)
                }
            }
        }
  
        task.resume()
        }
        
    }
    
    func parseJson(_ weatherdata:Data)->WeatherModel?{// PArsing json Data
        let decoder = JSONDecoder()
        do{
            let decodedData=try decoder.decode(WeatherData.self, from: weatherdata)
            
            let weatherid = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let cityname = decodedData.name
            
            let weathermodel = WeatherModel(conditionid: weatherid, cityname: cityname, temp: temp)
          return weathermodel
        }
        catch{
            delegate?.didFailwithError(error: error)
            return nil
        }
    }
    
   
      

        }

    

