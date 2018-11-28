//
//  parentGooglePlaces.swift
//  librarycards
//
//  Created by Jasmin Silva on 11/28/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import GooglePlaces


extension parentLogInVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        // Print place info to the console.
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        
        // TODO: Add code to get address components from the selected place.
        // Get the address components.
        if let addressLines = place.addressComponents {
            // Populate all of the address fields we can find.
            manager?.activePatron?.address1 = place.name
            for field in addressLines {
                switch field.type {
                case kGMSPlaceTypeStreetNumber:
                    let street_number = field.name
                    manager?.activePatron?.address = street_number
                // Print the items we aren't using.
                case kGMSPlaceTypeNeighborhood:
                    let neighborhood = field.name
                    manager?.activePatron?.neighborhood = neighborhood
                case kGMSPlaceTypeLocality:
                    let locality = field.name
                    manager?.activePatron?.locality = locality
                case kGMSPlaceTypeAdministrativeAreaLevel1:
                    let state = field.name
                    manager?.activePatron?.state = state
                case kGMSPlaceTypePostalCode:
                    let postalCode = field.name
                    manager?.activePatron?.zip = postalCode
                case kGMSPlaceTypeAdministrativeAreaLevel2:
                    let county = field.name
                    manager?.activePatron?.county = county
                default:
                    print("Type: \(field.type), Name: \(field.name)")
                }
            }
        }
        
        // Call custom function to populate the address form.
        address1TextField.text = place.formattedAddress ?? ""
        
        // Close the autocomplete widget.
        self.dismiss(animated: true, completion: nil)
        
        // Close the autocomplete widget.
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Show the network activity indicator.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    // Hide the network activity indicator.
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Set a filter to return only addresses.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        filter.country = "USA"
        autocompleteController.autocompleteFilter = filter
        
        present(autocompleteController, animated: true, completion: nil)
    }
}


