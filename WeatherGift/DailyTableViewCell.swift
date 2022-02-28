//
//  DailyTableViewCell.swift
//  WeatherGift
//
//  Created by song on 2/27/22.
//  Copyright © 2022 song. All rights reserved.
//

import UIKit

class DailyTableViewCell: UITableViewCell {

    
    @IBOutlet weak var dailyImageView: UIImageView!
    
    @IBOutlet weak var dailyWeekdayLabel: UILabel!
    
    @IBOutlet weak var dailyHighLabel: UILabel!
    @IBOutlet weak var dailyLowLabel: UILabel!
    @IBOutlet weak var dailySummaryView: UITextView!
    
    var dailyWeather: DailyWeather! {
        didSet {
            dailyImageView.image = UIImage(named: dailyWeather.dailyIcon)
            dailyWeekdayLabel.text = dailyWeather.dailyWeekday
            dailySummaryView.text = dailyWeather.dailySummary
            dailyHighLabel.text = "\(dailyWeather.dailyHigh)°"
            dailyLowLabel.text = "\(dailyWeather.dailyLow)°"
        }
    }
    
}
