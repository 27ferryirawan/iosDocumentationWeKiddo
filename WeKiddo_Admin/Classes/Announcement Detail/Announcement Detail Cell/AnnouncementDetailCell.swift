//
//  AnnouncementDetailCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 21/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol AnnouncementDetailCellDelegate: class {
    func previewImage(withImageURL: String)
}

class AnnouncementDetailCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headerCollection: UICollectionView!
    @IBOutlet weak var eventDateView: UIView!{
        didSet{
            eventDateView.layer.cornerRadius = 5
            eventDateView.clipsToBounds = true
            eventDateView.layer.borderWidth = 1
            eventDateView.layer.borderColor = UIColor(r : 241, g : 241, b : 243).cgColor
        }
    }
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    var mediaArray = [AnnouncementDetailMediasModel]()
    weak var delegate: AnnouncementDetailCellDelegate?
    var detailObj: AnnouncementDetail? {
        didSet {
            cellDataSet()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        headerCollection.delegate = self
        headerCollection.dataSource = self
//        galleryCollection.dataSource = self
//        galleryCollection.delegate = self
//        videoCollection.dataSource = self
//        videoCollection.delegate = self
        headerCollection.register(UINib(nibName: "AnnouncementBannerImageCell", bundle: nil), forCellWithReuseIdentifier: "announcementBannerImageCell")
//        galleryCollection.register(UINib(nibName: "AnnouncementImageGalleryCell", bundle: nil), forCellWithReuseIdentifier: "announcementImageGalleryCell")
//        videoCollection.register(UINib(nibName: "AnnouncementVideoCollectionCell", bundle: nil), forCellWithReuseIdentifier: "announcementVideoCollectionCell")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellDataSet() {
        guard let obj = detailObj else {
            return
        }
        self.titleLabel.text = obj.announcement_title
        self.monthLabel.text = "\(getMonth(time: obj.start_date))"
        self.dayLabel.text = "\(getDay(time: obj.start_date))"
        self.yearLabel.text = "\(getYear(time: obj.start_date))"
        self.descLabel.text = obj.announcement_desc
        for mediaObj in obj.medias {
            if mediaObj.media_type_id == "MT3" {
                mediaArray.append(mediaObj)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == headerCollection {
            return mediaArray.count
        }
//       else if collectionView == galleryCollection {
//            return 5
        else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let kWhateverHeightYouWant = 100
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == headerCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "announcementBannerImageCell", for: indexPath as IndexPath) as! AnnouncementBannerImageCell
            cell.detailObj = mediaArray[indexPath.row]
            return cell
//        } else if collectionView == galleryCollection {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "announcementImageGalleryCell", for: indexPath as IndexPath) as! AnnouncementImageGalleryCell
//            //            cell.configCell(index: indexPath.row)
//            return cell
        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "announcementVideoCollectionCell", for: indexPath as IndexPath) as! AnnouncementVideoCollectionCell
//            //            cell.configCell(index: indexPath.row)
//            return cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "announcementBannerImageCell", for: indexPath as IndexPath) as! AnnouncementBannerImageCell
            //            cell.configCell(index: indexPath.row)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.previewImage(withImageURL: mediaArray[indexPath.row].url)
    }
}

extension AnnouncementDetailCell {
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
        dateFormatterResult.dateFormat = "LLLL"
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
