//
//  SchoolHeaderCell.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 29/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.

import UIKit
import MapKit

protocol SchoolHeaderDelegate: class {
    func goToVideoPlayer(videoID: String)
}

class SchoolHeaderCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    @IBOutlet weak var websiteImg: UIImageView!
    @IBOutlet weak var igImg: UIImageView!
    @IBOutlet weak var getDirectionBtn: UIButton!{
        didSet{
            getDirectionBtn.layer.cornerRadius = 5
            getDirectionBtn.layer.borderColor = ACColor.MAIN.cgColor
            getDirectionBtn.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var imageCollection: UICollectionView!
    @IBOutlet weak var ytImg: UIImageView!
    @IBOutlet weak var logoImageUrl: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var gradeLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var contactPersonLbl: UILabel!
    @IBOutlet weak var videoCollection: UICollectionView!
    @IBOutlet weak var fbLbl: UILabel!
    @IBOutlet weak var ytLbl: UILabel!
    @IBOutlet weak var igLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var youtubeTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var instagramTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var websiteTopConstraint: NSLayoutConstraint!
    var mediaArray = [SchoolDetailMediaModel]()
    var videoArray = [SchoolDetailMediaModel]()
    weak var delegate: SchoolHeaderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        videoCollection.dataSource = self
        videoCollection.delegate = self
        imageCollection.dataSource = self
        imageCollection.delegate = self
        videoCollection.register(UINib(nibName: "VideoCollectionCell", bundle: nil), forCellWithReuseIdentifier: "videoCollectionCell")
        imageCollection.register(UINib(nibName: "SchoolDetailBannerCell", bundle: nil), forCellWithReuseIdentifier: "schoolDetailBannerCellID")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    var detailObj: SchoolDetailModel? {
        didSet {
            cellDataSet()
        }
    }
    func cellDataSet() {
        guard let obj = detailObj else {
            return
        }
        self.nameLbl.text = obj.school_name
        self.addressLbl.text = obj.school_address
        self.contactPersonLbl.text = obj.school_phone
        self.cityLbl.text = obj.school_city
        self.descriptionLbl.text = obj.school_desc
        fbLbl.text = obj.school_fb
        if !(obj.school_youtube == "") {
            self.ytLbl.text = obj.school_youtube
        } else {
            ytImg.isHidden = true
            ytLbl.isHidden = true
            instagramTopConstraint.constant = -30
            self.layoutIfNeeded()
        }
        if !(obj.school_ig == "") {
            self.igLbl.text = obj.school_ig
        } else {
            igImg.isHidden = true
            igLbl.isHidden = true
            websiteTopConstraint.constant = -30
            self.layoutIfNeeded()
        }
        self.websiteLbl.text = obj.school_website
        //latlong
        self.typeLbl.text = obj.school_type
        self.logoImageUrl.sd_setImage(
            with: URL(string: (ACData.SCHOOLDETAILDATA.school_logo)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        self.gradeLbl.text = obj.school_grade
        for mediaObj in ACData.SCHOOLDETAILDATA.school_medias {
            if mediaObj.media_type_name == "Video" {
                videoArray.append(mediaObj)
            }
        }
        for mediaObj in ACData.SCHOOLDETAILDATA.school_medias {
            if mediaObj.media_type_name == "Content Image" {
                mediaArray.append(mediaObj)
            }
        }
        imageCollection.reloadData()
        videoCollection.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageCollection {
            return mediaArray.count
        } else {
            return videoArray.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let kWhateverHeightYouWant = 100
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.width)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == videoCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCollectionCell", for: indexPath as IndexPath) as! VideoCollectionCell
            //            cell.configCell(index: indexPath.row)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "schoolDetailBannerCellID", for: indexPath as IndexPath) as! SchoolDetailBannerCell
            cell.configCell(index: indexPath.row)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let videoURL = URLComponents(string: videoArray[indexPath.row].media_url)?.queryItems?.first(where: { $0.name == "v" })?.value else {
            return
        }
        self.delegate?.goToVideoPlayer(videoID: videoURL)
    }
}
