//
//  WeatherDetail.swift
//  WeatherGift
//
//  Created by song on 2/26/22.
//  Copyright © 2022 song. All rights reserved.
//

import Foundation

private let dateFormatter: DateFormatter = {
    print("📆📆📆 I JUST CREATED A DATE FORMATTER in WeatherDetail.swift!")
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter
}()

struct DailyWeather {
    var dailyIcon: String
    var dailyWeekday: String
    var dailySummary: String
    var dailyHigh: Int
    var dailyLow: Int
}

class WeatherDetail: WeatherLocation {
    
    struct Result: Codable {
        var timezone: String
        var current: Current
        var daily: [Daily]
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
    
    struct Daily: Codable {
        var dt: TimeInterval
        var temp: Temp
        var weather: [Weather]
    }
    
    struct Temp: Codable {
        var max: Double
        var min: Double
    }
    
    var timezone = ""
    var currentTime = 0.0
    var temperature = 0
    var summary = ""
    var dayIcon = ""
    var dailyWeatherData: [DailyWeather] = []
    
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
                self.dayIcon = self.fileNameForIcon(icon: result.current.weather[0].icon)
//                print("*** DAILY WEATHER ARRAY \(result.daily)")
                for index in 0..<result.daily.count {
                    let weekdayDate = Date(timeIntervalSince1970: result.daily[index].dt)
                    dateFormatter.timeZone = TimeZone(identifier: result.timezone)
                    let dailyWeekday = dateFormatter.string(from: weekdayDate)
                    let dailyIcon = self.fileNameForIcon(icon: result.daily[index].weather[0].icon)
                    let dailySummary = result.daily[index].weather[0].description
                    let dailyHigh = Int (result.daily[index].temp.max.rounded())
                    let dailyLow = Int (result.daily[index].temp.min.rounded())
                    let dailyWeather = DailyWeather(dailyIcon: dailyIcon, dailyWeekday: dailyWeekday, dailySummary: dailySummary, dailyHigh: dailyHigh, dailyLow: dailyLow)
                    self.dailyWeatherData.append(dailyWeather)
                    print("Day: \(dailyWeekday), High: \(dailyHigh), Low: \(dailyLow)")
                }
                
                
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
