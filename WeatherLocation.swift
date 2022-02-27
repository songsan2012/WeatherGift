//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by song on 1/18/22.
//  Copyright © 2022 song. All rights reserved.
//

import Foundation

//struct WeatherLocation: Codable {
class WeatherLocation: Codable {
    
    var name: String
    var latitude: Double
    var longitude: Double
    
    init (name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func getData() {
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
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print ("😎 returned json is: \(json)")
            } catch {
                print("😡 JSON Error from session.datatask: \(error.localizedDescription)")
            }
            
        }
        
        task.resume()
        
    }
    
    
}
