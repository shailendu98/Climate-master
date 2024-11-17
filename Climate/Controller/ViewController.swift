//
//  ViewController.swift
//  Climate
//
//  Created by Shailedu on 16/05/24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    var weatherurldata = WeatherUrlData()
    var locationManager = CLLocationManager()
    
    
    @IBOutlet weak var weatherCondition: UIImageView!
    
    @IBOutlet weak var tempLebel: UILabel!
    
    
    @IBOutlet weak var placeLebel: UILabel!
    
    @IBOutlet weak var TextEntryField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate=self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        weatherurldata.delegate=self
        TextEntryField.delegate=self
    }
    
    @IBAction func locationpressed(_ sender: UIButton) {
        locationManager.requestLocation()
        
    }
    

}
// MARK: - TextFieldDelegate

extension ViewController: UITextFieldDelegate{
    
    @IBAction func searchPressed(_ sender: UIButton) {
        TextEntryField.endEditing(true)
        
       print( TextEntryField.text!)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        TextEntryField.endEditing(true)
        print(TextEntryField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if TextEntryField.text != ""{
            return true
        }
        else{
            TextEntryField.placeholder="Write something"
            return false
        }
    }
    

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let place = TextEntryField.text{
        weatherurldata.getWeatherData(city: place)
        }
        TextEntryField.text=""
    }
    
}
//MARK: - WeathermanagerDelegate
extension ViewController :WeatherManegerDeligate{
    
    
    
    func didUpdateWeather(_: WeatherUrlData,weather:WeatherModel){
        DispatchQueue.main.async {
        
        self.tempLebel.text=weather.tempString
            self.weatherCondition.image=UIImage(systemName:weather.conditionName )
            self.placeLebel.text=weather.cityname
        
    }
    }
    func didFailwithError(error: Error) {
        print(error)
    }
    
    
}
//MARK: - CLLocationManagerDelegate
extension ViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
        
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherurldata.getWeatherData(latitude :lat,longitude :lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
