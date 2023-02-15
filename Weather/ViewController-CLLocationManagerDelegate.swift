//
//  ViewController-CLLocationManagerDelegate.swift
//  Weather
//
//  Created by 项宇杰 on 2023/2/3.
//

import Foundation
import CoreLocation
import Alamofire
import SwiftyJSON

extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lon = locations[0].coordinate.longitude
        let lat = locations[0].coordinate.latitude
//        print(lon,lat)
        
        //获取天气信息
        AF.request("https://devapi.qweather.com/v7/weather/now?location=\(lon),\(lat)&key=9f7ee74c050549a78a77d496df369af3").responseJSON { response in
            if let data = response.value{
                let weatherJSON = JSON(data)
                
                self.weather.temp = weatherJSON["now"]["temp"].stringValue
                self.weather.icon = weatherJSON["now"]["icon"].stringValue
                self.updateTemp(temp: self.weather.temp)
                self.updateIcon(img: self.weather.icon)
            }
        }
        
        //获取城市信息
        AF.request("https://geoapi.qweather.com/v2/city/lookup?location=\(lon),\(lat)&key=9f7ee74c050549a78a77d496df369af3").responseJSON { response in
            if let data = response.value{
                let cityJSON = JSON(data)
                
                //print(cityJSON)
                self.weather.city = cityJSON["location"][0]["name"].stringValue
                self.updateCity(city: self.weather.city)
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        self.updateCity(city: "获取失败")
    }
}
