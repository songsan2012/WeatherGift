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
    
    
    
    
}
