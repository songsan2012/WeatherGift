//
//  WeatherDetail.swift
//  WeatherGift
//
//  Created by song on 2/26/22.
//  Copyright © 2022 song. All rights reserved.
//

import Foundation

class WeatherDetail: WeatherLocation {
    
    struct Result: Codable {
        var timezone: String
        var current: Current
    }
    
    struct Current: Codable {
        var dt: TimeInterval
        var temp: Double
        var weather: [Weather]
        
    }
    
    struct Weather: Codable {
        var description: String
        var icon: String
    }
    
    var timezone = ""
    var currentTime = 0.0
    var temperature = 0
    var summary = ""
    var dailyIcon = ""
    
    func getData(completed: @escaping () -> ()) {
//        let WeatherURLString = "https://api.openweathermap.org/data/2.5/onecall?lat=42.336778056535955&lon=-71.17073682897171&appid=67110bafc4115b579e127c47fb76650c"
//
        
        let WeatherURLString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&units=imperial&&appid=\(APIkeys.openWeatherKey)"
        
        
        let pokeapiURLString = "https://pokeapi.co/api/v2/pokemon/"
//        let urlString = pokeapiURLString
        let urlString = WeatherURLString
        
        print("🕸 We are accessing the url \(urlString)")
        
        // Create URL in iOS URL Format
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            completed()
            return
        }
        
        // Create session
        let session = URLSession.shared
        
        // get data with .dataTask method
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("😡 ERROR at session.dataTask: \(error.localizedDescription)")
            }
            
            
            // note: there are some additional things that could go wrong when using URLSession, but we shouldn't experience them, so we'll ignore testing for these for now....
            
            // deal with the data
            do {
//                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                
                let result = try JSONDecoder().decode(Result.self, from: data!)
                self.timezone = result.timezone
                self.currentTime = result.current.dt
                self.temperature = Int(result.current.temp.rounded())
                self.summary = result.current.weather[0].description
                self.dailyIcon = self.fileNameForIcon(icon: result.current.weather[0].icon)
                
            } catch {
                print("😡 JSON Error from session.datatask: \(error.localizedDescription)")
            }
            completed()
            
        }
        
        task.resume()
        
    }
    
    private func fileNameForIcon(icon: String) -> String
    {
        var newFileName = ""
        
        switch icon {
        case "01d":
            newFileName = "clear-day"
        case "01n":
            newFileName = "clear-night"
        case "02d":
            newFileName = "partly-cloudy-day"
        case "02n":
            newFileName = "partly-cloudy-night"
        case "03d", "03n", "04d", "04n":
            newFileName = "cloudy"
        case "09d", "09n", "10d", "10n":
            newFileName = "rain"
        case "11d", "11n":
            newFileName = "thunderstorm"
        case "13d", "13n":
            newFileName = "snow"
        case "50d", "50n":
            newFileName = "fog"
        default:
            newFileName = ""
            
            
        }
        return newFileName
    }
    
    
    
}
