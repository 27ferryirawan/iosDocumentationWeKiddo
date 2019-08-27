//
//  NotificationHeaderGalleryCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 17/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import MapKit
import Hex

protocol NotificationHeaderCellDelegate: class {
    func openMap(lat: Double, long: Double, placeName: String)
    func previewImage(withImageURL: String)
}

class NotificationHeaderGalleryCell: UITableViewCell {
    
    @IBOutlet weak var eventDateLbl: UILabel!{
        didSet{
            eventDateLbl.text = "Event Date"
        }
    }
    @IBOutlet weak var dueLbl: UILabel!{
        didSet{
            dueLbl.text = "Due"
        }
    }
    @IBOutlet weak var descriptionLbl: UILabel!{
        didSet{
            descriptionLbl.text = "Description"
            descriptionLbl.textColor = ACColor.MAIN
        }
    }
    @IBOutlet weak var dueDateView: UIView!{
        didSet{
            dueDateView.layer.cornerRadius = 5
            dueDateView.clipsToBounds = true
            dueDateView.layer.borderWidth = 1
            dueDateView.layer.borderColor = UIColor(hex: "CCCCCC").cgColor
        }
    }
    @IBOutlet weak var descContentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headerCollection: UICollectionView!
    @IBOutlet weak var eventFromDateView: UIView!{
        didSet{
            eventFromDateView.layer.cornerRadius = 5
            eventFromDateView.clipsToBounds = true
            eventFromDateView.layer.borderWidth = 1
            eventFromDateView.layer.borderColor = UIColor(hex: "CCCCCC").cgColor
        }
    }
    @IBOutlet weak var eventMonthFromLabel: UILabel!{
        didSet{
            eventMonthFromLabel.backgroundColor = ACColor.MAIN
        }
    }
    @IBOutlet weak var eventDayFromLabel: UILabel!
    @IBOutlet weak var eventYearFromLabel: UILabel!
    @IBOutlet weak var eventDayToLbl: UILabel!
    @IBOutlet weak var eventMonthToLbl: UILabel!{
        didSet{
            eventMonthToLbl.backgroundColor = ACColor.MAIN
        }
    }
    @IBOutlet weak var eventYearToLbl: UILabel!
    @IBOutlet weak var eventToView: UIView!{
        didSet{
            eventToView.layer.cornerRadius = 5
            eventToView.clipsToBounds = true
            eventToView.layer.borderWidth = 1
            eventToView.layer.borderColor = UIColor(hex: "CCCCCC").cgColor
        }
    }
    @IBOutlet weak var mapView: MKMapView!{
        didSet{
            mapView.layer.cornerRadius = 5
            mapView.clipsToBounds = true
            mapView.layer.borderWidth = 1
            mapView.layer.borderColor = UIColor(hex: "CCCCCC").cgColor
        }
    }
    @IBOutlet weak var directionBtn: UIButton!{
        didSet{
            directionBtn.layer.cornerRadius = 5
            directionBtn.layer.borderColor = UIColor(hex: "CCCCCC").cgColor
            directionBtn.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var dueMonthLbl: UILabel!{
        didSet{
            dueMonthLbl.backgroundColor = ACColor.MAIN
        }
    }
    @IBOutlet weak var dueYearLbl: UILabel!
    @IBOutlet weak var dueDayLbl: UILabel!
    var lat = 0.0
    var long = 0.0
    var detailObj: ApprovalDetailModel? {
        didSet {
            cellConfig()
        }
    }
    var mediaArray = [ApprovalDetailMediaModel]()
    weak var delegate: NotificationHeaderCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        headerCollection.delegate = self
        headerCollection.dataSource = self
        headerCollection.register(UINib(nibName: "NotificationDetailCollectionCell", bundle: nil), forCellWithReuseIdentifier: "notificationHeaderCell")
        directionBtn.addTarget(self, action: #selector(openInMap), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func openInMap() {
        guard let obj = detailObj else {
            return
        }
        self.delegate?.openMap(lat: lat, long: long, placeName:obj.event_name)
    }
    func cellConfig() {
        guard let obj = detailObj else {
            return
        }
        titleLabel.text = obj.event_name
        eventDayFromLabel.text = "\(getDay(time: obj.start_event_date))"
        eventMonthFromLabel.text = "\(getMonth(time: obj.start_event_date))"
        eventYearFromLabel.text = "\(getYear(time: obj.start_event_date))"
        
        eventDayToLbl.text = "\(getDay(time: obj.end_event_date))"
        eventMonthToLbl.text = "\(getMonth(time: obj.end_event_date))"
        eventYearToLbl.text = "\(getYear(time: obj.end_event_date))"
        
        dueDayLbl.text = "\(getDay(time: obj.event_due_date))"
        dueMonthLbl.text = "\(getMonth(time: obj.event_due_date))"
        dueYearLbl.text = "\(getYear(time: obj.event_due_date))"
        descContentLabel.text = obj.desc
        var locationArray = obj.event_latlong.components(separatedBy: ",")
        lat = Double(locationArray[0])!
        long = Double(locationArray[1])!
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        annotation.title = obj.event_name
        self.mapView.addAnnotation(annotation)
        for mediaObj in ACData.APPROVALDETAILDATA.medias {
            if mediaObj.media_type_id == "MT3" {
                print(mediaObj.url)
                mediaArray.append(mediaObj)
            }
        }
        headerCollection.reloadData()
    }
}

extension NotificationHeaderGalleryCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaArray.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.width)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "notificationHeaderCell", for: indexPath as IndexPath) as! NotificationDetailCollectionCell
        cell.detailObj = mediaArray[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.previewImage(withImageURL: mediaArray[indexPath.row].url)
    }
}
extension NotificationHeaderGalleryCell {
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
        dateFormatterResult.dateFormat = "MMMM"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
    
    func getDay(time: String) -> String {
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
        dateFormatterResult.dateFormat = "dd"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
    
    func getWeekDay(time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "EEE"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
    
    func getYear(time: String) -> String {
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
        dateFormatterResult.dateFormat = "yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
