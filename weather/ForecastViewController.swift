//
//  ForecastViewController.swift
//  weather
//
//  Created by Paul Min on 3/16/20.
//  Copyright © 2020 Paul Min. All rights reserved.
//
import AlamofireImage
import UIKit
import Foundation


class ForecastViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var city: String?
    
    @IBOutlet weak var cityLabel: UILabel!
    var forecasts = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        let base = "http://api.openweathermap.org/data/2.5/forecast?q="
        
        let appid = "&appid=b0e45b1598059575bfd71e5d3ed266c0"
        
        let fullUrl = base + (city!) + appid
        
        let url = URL(string: fullUrl)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            self.forecasts = dataDictionary["list"] as! [[String:Any]]
            self.tableView.reloadData()
            print(self.forecasts)
           }
        }
        task.resume()
    }
    
    func getDayOfWeek(_ today:String) -> String? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        
        let days = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday"
        ]
        
        return days[weekDay - 1]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count/8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell") as! ForecastCell
        
        let forecast = forecasts[indexPath.row * 8]
        
        let date_text = forecast["dt_txt"] as! String
        let date_array = date_text.split(separator: " ")
        let date = date_array[0]
        let dayOfWeek = self.getDayOfWeek(String(date))!
        
        let weather = forecast["weather"] as! [[String:Any]]
        let description = weather[0]["description"] as! String
        
        let icon = weather[0]["icon"] as! String
        let base_url = "http://openweathermap.org/img/w/"
        let postfix = ".png"
        
        let iconUrl = URL(string: base_url + icon + postfix)
        
        cell.cityLabel.text = city
        cell.dayLabel.text = "\(dayOfWeek), \(date_text)"
        cell.descriptionLabel.text = description
        cell.iconImage.af_setImage(withURL: iconUrl!)
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
