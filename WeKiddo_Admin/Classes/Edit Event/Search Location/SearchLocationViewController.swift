//
//  SearchLocationViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 29/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import MapKit

protocol SearchLocationViewControllerDelegate: class {
    func updateLocationWithValue(name: String, desc: String, lat: Double, long: Double)
}

class SearchLocationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
    var titleAddress = ""
    var descAddress = ""
    var latitude = 0.0
    var longitude = 0.0
    
    weak var delegate: SearchLocationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SearchLocationCell", bundle: nil), forCellReuseIdentifier: "searchLocationCellID")
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.delegate?.updateLocationWithValue(name: titleAddress, desc: descAddress, lat: latitude, long: longitude)
    }
    func parseAddress(selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
}

extension SearchLocationViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text!.count > 2 {
            guard let mapView = mapView,
            let searchBarText = searchBar.text else { return }
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = searchBarText
            request.region = mapView.region
            let search = MKLocalSearch(request: request)
            search.start { response, _ in
                guard let response = response else {
                    return
                }
                self.matchingItems = response.mapItems
                self.tableView.reloadData()
            }
        }
        searchBar.resignFirstResponder()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {

    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}

extension SearchLocationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "searchLocationCellID", for: indexPath) as? SearchLocationCell)!
        let selectedItem = matchingItems[indexPath.row].placemark
        let name = selectedItem.name!
        cell.title.text = name
        cell.desc.text = parseAddress(selectedItem: selectedItem)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        let name = selectedItem.name!
        titleAddress = name
        descAddress = parseAddress(selectedItem: selectedItem)
        latitude = selectedItem.coordinate.latitude
        longitude = selectedItem.coordinate.longitude
        self.navigationController?.popViewController(animated: true)
    }
}
