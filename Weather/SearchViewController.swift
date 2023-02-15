//
//  SearchViewController.swift
//  Weather
//
//  Created by 项宇杰 on 2023/2/3.
//

import UIKit

protocol SearchViewControllerDelegate{
    func didChangeCity(city: String)
}

class SearchViewController: UIViewController {

    var currentCity = ""
    var delegate: SearchViewControllerDelegate?
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var currentCityLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityTextField.becomeFirstResponder()
        currentCityLabel.text = currentCity
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func query(_ sender: Any) {
        dismiss(animated: true)
        
        if !cityTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            delegate?.didChangeCity(city: cityTextField.text!)
        }
    }
    
}
