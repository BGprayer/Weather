//
//  ViewController-SearchViewControllerDelegate.swift
//  Weather
//
//  Created by 项宇杰 on 2023/2/3.
//

import Foundation
import CoreLocation
import Alamofire
import SwiftyJSON

extension ViewController: SearchViewControllerDelegate{
    func didChangeCity(city: String) {
        print(city)
        let parameters = ["location": city, "key": "9f7ee74c050549a78a77d496df369af3"]
        AF.request("https://geoapi.qweather.com/v2/city/lookup",parameters: parameters).responseJSON { response in
            if let data = response.value{
                let cityJSON = JSON(data)
                
                //print(cityJSON)
                self.weather.city = cityJSON["location"][0]["name"].stringValue
                self.updateCity(city: self.weather.city)
                
                let cityID = cityJSON["location"][0]["id"]
                
                AF.request("https://devapi.qweather.com/v7/weather/now?location=\(cityID)&key=9f7ee74c050549a78a77d496df369af3").responseJSON { response in
                    if let data = response.value{
                        let weatherJSON = JSON(data)
                        print(weatherJSON)
                        
                        self.weather.temp = weatherJSON["now"]["temp"].stringValue
                        self.weather.icon = weatherJSON["now"]["icon"].stringValue
                        self.updateTemp(temp: self.weather.temp)
                        self.updateIcon(img: self.weather.icon)
                    }
                }
            }
        }
    }

}
