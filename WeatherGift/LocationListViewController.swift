//
//  LocationListViewController.swift
//  WeatherGift
//
//  Created by song on 1/18/22.
//  Copyright © 2022 song. All rights reserved.
//

import UIKit

class LocationListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var addLocationBarButton: UIBarButtonItem!
    
    var weatherLocations: [WeatherLocation] = []
    
    // -- create an Inventory Array
    var inventories: [Inventory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // -- Populate Weather Locations
        var weatherLocation = WeatherLocation(name: "Rosemead, CA", latitude: 0.0, longitude: 0.0)
        weatherLocations.append(weatherLocation)
        
        weatherLocation = WeatherLocation(name: "Torrance, CA", latitude: 100.0, longitude: 100.0)
        weatherLocations.append(weatherLocation)
        
        
        var inventory = Inventory(name: "Plates of 100", quantity: 1, cost: 5.0)
        inventories.append(inventory)
        
         inventory = Inventory(name: "Pineapple", quantity: 2, cost: 2.25)
        inventories.append(inventory)
        
        
        // -- Set the data
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    @IBAction func editBarButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            sender.title = "Edit"
            addLocationBarButton.isEnabled = true
        }
        else {
            tableView.setEditing(true, animated: true)
            sender.title = "Done"
            addLocationBarButton.isEnabled = false
            
        }
        
    }
    
    
    @IBAction func addLocationBarButtonPressed(_ sender: UIBarButtonItem) {
        
        // -- create the add functionality
        
    }
    
    // -- To Save Data to iOS - Start
            func saveData() {
//                weatherLocations .saveData()
//                weatherLocations.sa
                
    //            setNotifications()
            }
        // -- To Save Data to iOS - End
        
    


}


extension LocationListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherLocations.count
//        return inventories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = weatherLocations[indexPath.row].name
//        cell.textLabel?.text = inventories[indexPath.row].name + " ; qty " + String(inventories[indexPath.row].quantity)

        return cell
    }
    
    
    // -- Edit row functionality - Start
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            if editingStyle == .delete {
                weatherLocations.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
//                saveData()
            }
            
        }
    // -- Edit row funcationlity - End
    
    
    // -- Move row functionality - Start
        func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            
            
            let itemToMove = weatherLocations[sourceIndexPath.row]
            weatherLocations.remove(at: sourceIndexPath.row)
            weatherLocations.insert(itemToMove, at: destinationIndexPath.row)

            
        }
    
    // -- Move row functionality - End
    
}

