//
//  ViewController.swift
//  API Request
//
//  Created by Apple on 15/02/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = "https://api.sunrise-sunset.org/json?date=2020-01-01&lat=74.0060&lng=40.7128&formatted=0"
        getData(from: url)
    }
    
    private func getData(from url: String){
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else{
                print("Something went wrong")
                return
            }
            
            var result: Response?
            do{
                result = try JSONDecoder().decode(Response.self, from: data)
            }
            catch{
                print("Failed to convert \(error.localizedDescription)")
            }
            
            guard let json = result else{
                return
            }
            
            print(json.status)
            print(json.results.sunrise)
            print(json.results.sunset)
            print(json.results.solar_moon)
        })
        
        task.resume()
    }


}

struct Response: Codable{
    let results: MyResult
    let status: String
}

struct MyResult: Codable{
    let sunrise: String
    let sunset: String
    let solar_moon: String
    let day_length: Int
    let civil_twilight_begin: String
    let civil_twilight_end: String
    let nautical_twilight_begin: String
    let nautical_twilight_end: String
    let astronomical_twilight_begin: String
    let astronomical_twilight_end: String
}
