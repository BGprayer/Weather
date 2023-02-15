//
//  ViewController.swift
//  Weather
//
//  Created by 项宇杰 on 2023/2/1.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController{

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    let locationManager = CLLocationManager()
    
    let weather = Weather()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.requestWhenInUseAuthorization() //询问获取当前位置信息
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestLocation()
    }
    
    func updateTemp(temp: String){
        tempLabel.text = "\(temp)˚"
    }
    
    func updateIcon(img: String){
        iconImageView.image = UIImage(named: img)
    }
    
    func updateCity(city: String){
        cityLabel.text = city
    }
    
    
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
//        if segue.identifier == "SearchViewControllerSegue"{
//            let vc = segue.destination as! SearchViewController
//            vc.currentCity = weather.city
//        }
        
        if let vc = segue.destination as? SearchViewController{
            vc.currentCity = weather.city
            vc.delegate = self
        }
    }
    
}

