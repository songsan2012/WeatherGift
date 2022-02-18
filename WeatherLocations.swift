//
//  WeatherLocations.swift
//  WeatherGift
//
//  Created by song on 1/18/22.
//  Copyright © 2022 song. All rights reserved.
//

import Foundation

struct WeatherLocations {
    
    //    var itemsArray: [ToDoItem] = []
     var itemsArray: [WeatherLocation] = []
        
        func loadData(completed: @escaping ()->() ) {
             let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
             let documentURL = directoryURL.appendingPathComponent("weatherlocations").appendingPathExtension("json")

            guard let data = try? Data(contentsOf: documentURL) else { return }
            let jsonDecoder = JSONDecoder()
            do {
//                itemsArray = try jsonDecoder.decode(Array<ToDoItem>.self, from: data)
//                itemsArray = try jsonDecoder.decode(Array<WeatherLocation>.self, from: data)
            }  catch {
                print("😡 ERROR: Could not LOAD data \(error.localizedDescription)")
            }
            completed()
        }
        
        func saveData() {
            let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let documentURL = directoryURL.appendingPathComponent("weatherlocations").appendingPathExtension("json")
            
            let jsonEncoder = JSONEncoder()
    //        let data = try? jsonEncoder.encode(toDoItems)
            let data = try? jsonEncoder.encode(itemsArray)
            
            do {
                try data?.write(to: documentURL, options: .noFileProtection)
            } catch {
                print("😡 ERROR: Could not SAVE data \(error.localizedDescription)")
            }
            
//            setNotifications()
            
        }
}
