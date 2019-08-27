//
//  EditEventTopCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 28/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import MapKit
import CoreLocation
import UITextView_Placeholder

protocol EditEventTopCellDelegate: class {
    func titleHeaderFilled(withString: String)
    func publishDateSelected(withDate: String)
    func dueDateSelected(withDate: String)
    func endDateSelected(withDate: String)
    func descFilled(withString: String)
    func staticDescFilled(withString: String)
    func showBannerPicker()
    func amountFilled(withString: String)
    func showAddDescPopUp()
    func toSearchAddress(withMap: MKMapView)
}

class EditEventTopCell: UITableViewCell, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var addrTitle = ""
    var addrDesc = ""
    var addrLat = 0.0
    var addrLong = 0.0
    var isEdit = false
    let locationManager =  CLLocationManager()
    @IBOutlet weak var dueDateButton: UIButton!
    @IBOutlet weak var descHeaderText: UITextView!
    @IBOutlet weak var endDateButton: UIButton!
    @IBOutlet weak var publishDateButton: UIButton!
    @IBOutlet weak var bannerPhotoCollectiob: UICollectionView!
    @IBOutlet weak var bannerPhotoButton: UIButton! {
        didSet {
            bannerPhotoButton.layer.cornerRadius = 5.0
            bannerPhotoButton.layer.masksToBounds = true
            bannerPhotoButton.layer.borderWidth = 0.5
            bannerPhotoButton.layer.borderColor = ACColor.MAIN.cgColor
        }
    }
    
    @IBOutlet weak var addDescButton: UIButton!
    @IBOutlet weak var amountText: UITextField!
    @IBOutlet weak var isChargeSwitch: UISwitch!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addressDescText: UITextView!
    var titleHeader = ""
    weak var delegate: EditEventTopCellDelegate?
    var detailObj: AttachmentBannerModel? {
        didSet {
            cellConfig()
        }
    }
    var detailObjEdit: ApprovalDetailModel? {
        didSet {
            cellConfigEdit()
        }
    }
    var mediaArray = [BannerMediaModel]()
    override func awakeFromNib() {
        super.awakeFromNib()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 8.0, *) {
            locationManager.requestAlwaysAuthorization()
        } else {
            // Fallback on earlier versions
        }
        locationManager.startUpdatingLocation()
        
        publishDateButton.addTarget(self, action: #selector(showPublishDatePicker), for: .touchUpInside)
        endDateButton.addTarget(self, action: #selector(showEndDatePicker), for: .touchUpInside)
        dueDateButton.addTarget(self, action: #selector(showDueDatePicker), for: .touchUpInside)
        addDescButton.addTarget(self, action: #selector(addDescAction), for: .touchUpInside)
//        dateLabel.text = "Date : \(getMonth())"
        titleText.text = titleHeader
        bannerPhotoButton.addTarget(self, action: #selector(showBannerImagePicker), for: .touchUpInside)
        bannerPhotoCollectiob.register(UINib(nibName: "EditEventBannerCollectionCell", bundle: nil), forCellWithReuseIdentifier: "editEventBannerCollectionCellId")
        DispatchQueue.main.async {
            self.bannerPhotoCollectiob.reloadData()
            self.bannerPhotoCollectiob.collectionViewLayout.invalidateLayout()
        }
    }
    @IBAction func toSearchButton(_ sender: Any) {
        self.delegate?.toSearchAddress(withMap: self.mapView)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func switchChange(_ sender: Any) {
        if isChargeSwitch.isOn {
            amountText.isUserInteractionEnabled = true
        } else {
            amountText.isUserInteractionEnabled = false
        }
    }
    @objc func addDescAction() {
        self.delegate?.showAddDescPopUp()
    }
    func cellConfig() {        
        //        guard let obj = detailObj else { return }
        //        bannerPhotoCollectiob.reloadData()
    }
    func cellConfigEdit() {
        guard let obj = detailObjEdit else {
            return
        }
        titleText.text = obj.event_name
        publishDateButton.setTitle(getMonth(time: obj.start_event_date), for: .normal)
        endDateButton.setTitle(getMonth(time: obj.end_event_date), for: .normal)
        dueDateButton.setTitle(getMonth(time: obj.event_due_date), for: .normal)
        
        descHeaderText.text = obj.event_name
        addressDescText.text = obj.desc
        var locationArray = obj.event_latlong.components(separatedBy: ",")
        addrLat = Double(locationArray[0])!
        addrLong = Double(locationArray[1])!
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: addrLat, longitude: addrLong)
        annotation.title = obj.event_name
        self.mapView.addAnnotation(annotation)
//        mediaArray.removeAll()
        for mediaObj in ACData.APPROVALDETAILDATA.medias {
            if mediaObj.media_type_id == "MT3" {
                print(mediaObj.url)
//                if mediaArray.count == 0 {
                    mediaArray.append(BannerMediaModel(fileID: mediaObj.media_id, fileURL: mediaObj.url, fileType: mediaObj.media_type_id))
                    let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode(mediaArray) {
                        let defaults = UserDefaults.standard
                        defaults.set(encoded, forKey: "bannerMediaSelected")
                    }
//                }
            }
        }
        if obj.is_charge {
            isChargeSwitch.setOn(true, animated: false)
        } else {
            isChargeSwitch.setOn(false, animated: false)
        }
        amountText.text = obj.amount
        isEdit = true
        bannerPhotoCollectiob.reloadData()
    }
    
    @objc func showDueDatePicker() {
        ActionSheetDatePicker.show(
            withTitle: "- Select Date -",
            datePickerMode: .date,
            selectedDate: Date(),
            doneBlock: { picker, selectedDate, origin in
                let dateFormatter = DateFormatter()
                let dateFormatter2 = DateFormatter()
                let locale = Locale(identifier: "id")
                dateFormatter.dateFormat = "dd / MM / yyyy"
                dateFormatter2.dateFormat = "yyyy-MM-dd"
                dateFormatter.locale = locale
                dateFormatter2.locale = locale
                let selectedDates = dateFormatter.string(from: selectedDate as! Date)
                let choosenDate = dateFormatter2.string(from: selectedDate as! Date)
                self.dueDateButton.setTitle(selectedDates, for: .normal)
                self.delegate?.dueDateSelected(withDate: choosenDate)
        }, cancel: nil, origin: self)
    }
    @objc func showPublishDatePicker() {
        ActionSheetDatePicker.show(
            withTitle: "- Select Date -",
            datePickerMode: .date,
            selectedDate: Date(),
            doneBlock: { picker, selectedDate, origin in
                let dateFormatter = DateFormatter()
                let dateFormatter2 = DateFormatter()
                let locale = Locale(identifier: "id")
                dateFormatter.dateFormat = "dd / MM / yyyy"
                dateFormatter2.dateFormat = "yyyy-MM-dd"
                dateFormatter.locale = locale
                dateFormatter2.locale = locale
                let selectedDates = dateFormatter.string(from: selectedDate as! Date)
                let choosenDate = dateFormatter2.string(from: selectedDate as! Date)
                self.publishDateButton.setTitle(selectedDates, for: .normal)
                self.delegate?.publishDateSelected(withDate: choosenDate)
        }, cancel: nil, origin: self)
    }
    @objc func showEndDatePicker() {
        ActionSheetDatePicker.show(
            withTitle: "- Select Date -",
            datePickerMode: .date,
            selectedDate: Date(),
            doneBlock: { picker, selectedDate, origin in
                let dateFormatter = DateFormatter()
                let dateFormatter2 = DateFormatter()
                let locale = Locale(identifier: "id")
                dateFormatter.dateFormat = "dd / MM / yyyy"
                dateFormatter2.dateFormat = "yyyy-MM-dd"
                dateFormatter.locale = locale
                dateFormatter2.locale = locale
                let selectedDates = dateFormatter.string(from: selectedDate as! Date)
                let choosenDate = dateFormatter2.string(from: selectedDate as! Date)
                self.endDateButton.setTitle(selectedDates, for: .normal)
                self.delegate?.endDateSelected(withDate: choosenDate)
        }, cancel: nil, origin: self)
    }
    @objc func showBannerImagePicker() {
        self.delegate?.showBannerPicker()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == titleText {
            self.delegate?.titleHeaderFilled(withString: textField.text!)
        } else {
            self.delegate?.amountFilled(withString: textField.text!)
        }
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            if textView == descHeaderText {
                self.delegate?.descFilled(withString: textView.text!)
            } else if textView == addressDescText {
                self.delegate?.staticDescFilled(withString: textView.text!)
            }
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
        }
    }
}

extension EditEventTopCell {
    func getMonth() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        let result = formatter.string(from: date)
        return result
    }
}

extension EditEventTopCell: MKMapViewDelegate, CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "userLocation")
            annotationView.image = UIImage(named:"icon_location")
            return annotationView
        }
        return nil
    }
    /*
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) -> String {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        var addressString : String = ""
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    print(pm.country)
                    print(pm.locality)
                    print(pm.subLocality)
                    print(pm.thoroughfare)
                    print(pm.postalCode)
                    print(pm.subThoroughfare)

                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    print(addressString)
                }
        })
        return addressString
    }
    */
}

extension EditEventTopCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isEdit {
            return mediaArray.count
        } else {
            return ACData.ATTACHMENTBANNERDATA.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "editEventBannerCollectionCellId", for: indexPath) as? EditEventBannerCollectionCell)!
        if isEdit {
           cell.detailObj = mediaArray[indexPath.row]
        } else {
            cell.contentObj = ACData.ATTACHMENTBANNERDATA[indexPath.row]
        }
        return cell
    }
}

extension EditEventTopCell {
    func getMonth(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        // then convert date to string again
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "dd/MM/yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
