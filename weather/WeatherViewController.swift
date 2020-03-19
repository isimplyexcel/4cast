//
//  WeatherViewController.swift
//  weather
//
//  Created by Paul Min on 3/16/20.
//  Copyright © 2020 Paul Min. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var cityTextInput: UITextField!
    
    @IBAction func clickSearchBtn(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let forecastVC = segue.destination as? ForecastViewController else {
                return
            }
        forecastVC.city = cityTextInput.text
        cityTextInput.text = ""
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


