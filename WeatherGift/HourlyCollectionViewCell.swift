//
//  HourlyCollectionViewCell.swift
//  WeatherGift
//
//  Created by song on 2/27/22.
//  Copyright © 2022 song. All rights reserved.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var hourlyTemperature: UILabel!
    
    
    var hourlyWeather: HourlyWeather! {
        didSet {
            hourLabel.text = hourlyWeather.hour
            // TODO: Add icons later
            iconImageView.image = UIImage(systemName: hourlyWeather.hourlyIcon)
            hourlyTemperature.text = "\(hourlyWeather.hourlyTemperature)°"
            
        }
    }
    
    
}
