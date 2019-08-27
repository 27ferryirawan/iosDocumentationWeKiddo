//
//  AnnouncementDetailFooterCell.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 01/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol AnnouncementDetailFooterDelegate: class {
    func previewImage(withImageURL: String)
    func playVideo(withURL: String)
    func toEditAnnouncementPage()
}

class AnnouncementDetailFooterCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var editButton: UIButton! {
        didSet {
            editButton.layer.cornerRadius = 5.0
            editButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var deleteButton: UIButton! {
        didSet {
            deleteButton.layer.cornerRadius = 5.0
            deleteButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var videoCollection: UICollectionView!
    @IBOutlet weak var galleryCollection: UICollectionView!
    var mediaArray = [AnnouncementDetailMediasModel]()
    var videoArray = [AnnouncementDetailMediasModel]()
    var detailObj: AnnouncementDetail? {
        didSet {
            cellConfig()
        }
    }
    weak var delegate: AnnouncementDetailFooterDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        galleryCollection.dataSource = self
        galleryCollection.delegate = self
        videoCollection.dataSource = self
        videoCollection.delegate = self
        galleryCollection.register(UINib(nibName: "AnnouncementImageGalleryCell", bundle: nil), forCellWithReuseIdentifier: "announcementImageGalleryCell")
        videoCollection.register(UINib(nibName: "AnnouncementVideoCollectionCell", bundle: nil), forCellWithReuseIdentifier: "announcementVideoCollectionCell")
        deleteButton.addTarget(self, action: #selector(deleteAnnouncement), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(editAnnouncement), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
    }
    @objc func deleteAnnouncement() {
        
    }
    @objc func editAnnouncement() {
        guard let obj = detailObj else { return }
        ACRequest.GET_ANNOUNCEMENT_DETAIL_FOR_EDIT(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, announcementID: obj.school_announcement_id, accessToken: ACData.LOGINDATA.accessToken, successCompletion: { (detailEdit) in
            ACData.ANNOUNCEMENTEDITDETAILDATA = detailEdit
            SVProgressHUD.dismiss()
            self.delegate?.toEditAnnouncementPage()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == galleryCollection {
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
        if collectionView == galleryCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "announcementImageGalleryCell", for: indexPath as IndexPath) as! AnnouncementImageGalleryCell
            cell.detailObj = mediaArray[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "announcementVideoCollectionCell", for: indexPath as IndexPath) as! AnnouncementVideoCollectionCell
            cell.detailObj = videoArray[indexPath.row]
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == galleryCollection {
            self.delegate?.previewImage(withImageURL: mediaArray[indexPath.row].url)
        } else {
            self.delegate?.playVideo(withURL: videoArray[indexPath.row].url)
        }
    }
}
