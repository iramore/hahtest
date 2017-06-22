//
//  WetherDataModel.swift
//  HeadsAndHandsTest
//
//  Created by infuntis on 22/06/17.
//  Copyright © 2017 gala. All rights reserved.
//

import Alamofire

class WeaterDataModel {
    
    var temp: String?
    var location: String?
    var weather: String?
    typealias JSONStandard = Dictionary<String, AnyObject>
    
    let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Moscow&appid=71088be64cfb92d11556949eb39bf842")!
    
    
    
    func downloadWeather() {
        
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            let result = response.result
            
            if let dict = result.value as? JSONStandard, let main = dict["main"] as? JSONStandard, let temp = main["temp"] as? Double, let weatherArray = dict["weather"] as? [JSONStandard], let weather = weatherArray[0]["main"] as? String, let name = dict["name"] as? String, let sys = dict["sys"] as? JSONStandard, let country = sys["country"] as? String {
                
                self.temp = String(format: "%.0f °C", temp - 273.15)
                self.weather = weather
                self.location = "\(name), \(country)"
                
            }
            
        })
    }
    
}
