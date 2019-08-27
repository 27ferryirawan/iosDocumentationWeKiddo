//
//  NearbyViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 13/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import MapKit
import SVProgressHUD

class NearbyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var lat = 0.0
    var long = 0.0
    var isMapView: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configView()
        locationManager.startUpdatingLocation()
//        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        fetchData()
        obtainUserLocation()
        mapView.delegate = self
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Nearby Course", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Nearby Course", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "NearbyHeaderCell", bundle: nil), forCellReuseIdentifier: "nearbyHeaderCell")
        tableView.register(UINib(nibName: "NearbyContentCell", bundle: nil), forCellReuseIdentifier: "nearbyContentCell")
    }
    func fetchData() {
        ACRequest.GET_NEARBY_DATA(successCompletion: { (nearbyDatas) in
            ACData.NEARBYDATA = nearbyDatas
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func obtainUserLocation() {
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        
        locationManager.startUpdatingLocation()
        let annotation = MKPointAnnotation()
        // Set the annotation by the lat and long variables
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        annotation.title = "User location"
        self.mapView.addAnnotation(annotation)
    }
    func configView() {
        if isMapView {
            generateAnnotation()
            tableView.isHidden = true
            mapView.isHidden = false
        } else {
            tableView.isHidden = false
            mapView.isHidden = true
        }
    }
    @IBAction func switchView(_ sender: UIButton) {
        if isMapView {
            configView()
            isMapView = false
        } else {
            configView()
            isMapView = true
        }
    }
    func generateAnnotation() {
        for (index, object) in ACData.NEARBYDATA.enumerated() {
            for (indexx, objectChild) in object.courses.enumerated() {
                print(objectChild.course_lat)
                let london = MKPointAnnotation()
                london.title = objectChild.course_name
                london.coordinate = CLLocationCoordinate2D(latitude: objectChild.course_lat, longitude: objectChild.course_long)
                mapView.addAnnotation(london)
            }
        }
    }
    @objc func goToMore(sender: UIButton) {
        ACData.NEARBYCOURSEMOREDATA.removeAll()
        ACRequest.GET_NEARBY_MORE(courseCategoryId: sender.tag, successCompletion: { (nearbyMoreData) in
            ACData.NEARBYCOURSEMOREDATA = nearbyMoreData
            SVProgressHUD.dismiss()
            let nearbyMoreVC = NearbyCourseMoreViewController()
//            nearbyMoreVC.categoryID = sender.tag
            self.navigationController?.pushViewController(nearbyMoreVC, animated: true)
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
}

extension NearbyViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // 3 diganti dengan jumlah category yang akan di tampilkan based on backend
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + ACData.NEARBYDATA.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 200 : 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "nearbyHeaderCell", for: indexPath) as? NearbyHeaderCell)!
            
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "nearbyContentCell", for: indexPath) as? NearbyContentCell)!
            cell.delegate = self
            cell.arrayForCollectionView = ACData.NEARBYDATA[indexPath.row-1].courses
            cell.config(index: indexPath.row)
            cell.moreButton.tag = ACData.NEARBYDATA[indexPath.row-1].course_category_id
            cell.moreButton.addTarget(self, action: #selector(goToMore), for: .touchUpInside)
            return cell
        }
    }
}

extension NearbyViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    // To get the location for the user
    private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocationCoordinate2D = manager.location!.coordinate
        lat = location.latitude
        long = location.longitude
    }
    
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error")
    }
}

extension NearbyViewController: NearbyDelegate {
    func goToCourseDetail() {
        let courseDetailVC = CourseDetailViewController()
        self.navigationController?.pushViewController(courseDetailVC, animated: true)
    }
}
