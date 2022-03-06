//
//  LocationListViewController.swift
//  WeatherGift
//
//  Created by song on 1/18/22.
//  Copyright © 2022 song. All rights reserved.
//

import UIKit
import GooglePlaces

class LocationListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var addLocationBarButton: UIBarButtonItem!
    
    var weatherLocations: [WeatherLocation] = []
    var selectedLocationIndex = 0
    
    // -- create an Inventory Array
    var inventories: [Inventory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // -- Populate Weather Locations

        
        
        var inventory = Inventory(name: "Plates of 100", quantity: 1, cost: 5.0)
        inventories.append(inventory)
        
         inventory = Inventory(name: "Pineapple", quantity: 2, cost: 2.25)
        inventories.append(inventory)
        
        
        // -- Set the data
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func saveLocations() {
        let encoder = JSONEncoder()
         
        if let encoded = try? encoder.encode(weatherLocations) {
            UserDefaults.standard.set(encoded, forKey: "weatherLocations")
        }
        else {
            print("😡 ERROR: Saving encoded didn't work!")
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        selectedLocationIndex = tableView.indexPathForSelectedRow!.row
        saveLocations()
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
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self

//        // Specify the place data types to return.
//        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
//          UInt(GMSPlaceField.placeID.rawValue))!
//        autocompleteController.placeFields = fields
//
//        // Specify a filter.
//        let filter = GMSAutocompleteFilter()
//        filter.type = .address
//        autocompleteController.autocompleteFilter = filter

        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
        
        
        
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
        cell.detailTextLabel?.text = "Lat:\(weatherLocations[indexPath.row].latitude), Long: \(weatherLocations[indexPath.row].longitude)"
        

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
    
    
    // MARK:- tableView methods to freeze the first cell
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return (indexPath.row != 0 ? true : false)
//    }
//    
//    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        return (indexPath.row != 0 ? true : false)
//    }
//    
//    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
//        return (proposedDestinationIndexPath.row == 0 ? sourceIndexPath : proposedDestinationIndexPath)
//    }
    
}


extension LocationListViewController: GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    
      let newLocation = WeatherLocation(name: place.name ?? "unknown place", latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
      weatherLocations.append(newLocation)
      tableView.reloadData()
      
    dismiss(animated: true, completion: nil)
  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

  // User canceled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }

  // Turn the network activity indicator on and off again.
//  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//    UIApplication.shared.isNetworkActivityIndicatorVisible = true
//  }
//
//  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//    UIApplication.shared.isNetworkActivityIndicatorVisible = false
//  }

}

