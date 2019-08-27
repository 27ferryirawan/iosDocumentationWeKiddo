//
//  EditEventFooterCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 28/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import SVProgressHUD

protocol EditEventFooterCellDelegate: class {
    func addMoreDesc()
    func openImageGallery()
    func openVideoGallery()
    func levelSelected(withValue: String)
    func classSelected(withValue: String)
    func addNewEvent()
}

class EditEventFooterCell: UITableViewCell {
    
    @IBOutlet weak var saveNewEvent: UIButton!
    @IBOutlet weak var classPickerButton: UIButton!
    @IBOutlet weak var levelPickerButton: UIButton!
    @IBOutlet weak var videoCollection: UICollectionView!
    @IBOutlet weak var addVideoButton: UIButton! {
        didSet {
            addVideoButton.layer.cornerRadius = 5.0
            addVideoButton.layer.masksToBounds = true
            addVideoButton.layer.borderWidth = 0.5
            addVideoButton.layer.borderColor = ACColor.MAIN.cgColor
        }
    }
    @IBOutlet weak var pictureCollection: UICollectionView!
    @IBOutlet weak var addPictButton: UIButton! {
        didSet {
            addPictButton.layer.cornerRadius = 5.0
            addPictButton.layer.masksToBounds = true
            addPictButton.layer.borderWidth = 0.5
            addPictButton.layer.borderColor = ACColor.MAIN.cgColor
        }
    }
    @IBOutlet weak var addMoreDescButton: UIButton!
    weak var delegate: EditEventFooterCellDelegate?
    var levelName = [String]()
    var className = [String]()
    var galleryArray = [GalleryMediaModel]()
    var videoArray = [VideoMediaModel]()
    var levelID = ""
    var classID = ""
    var isEdit = false
    var detailObjEdit: ApprovalDetailModel? {
        didSet {
            cellConfigEdit()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        addPictButton.addTarget(self, action: #selector(showPictGallery), for: .touchUpInside)
        addVideoButton.addTarget(self, action: #selector(showVideoGallery), for: .touchUpInside)
        levelPickerButton.addTarget(self, action: #selector(showLevelPicker), for: .touchUpInside)
        classPickerButton.addTarget(self, action: #selector(showClassPicker), for: .touchUpInside)
        saveNewEvent.addTarget(self, action: #selector(saveEvent), for: .touchUpInside)
        pictureCollection.register(UINib(nibName: "ImageMediaCollectionCell", bundle: nil), forCellWithReuseIdentifier: "imageMediaCollectionCellID")
        videoCollection.register(UINib(nibName: "VideoMediaCollectionCell", bundle: nil), forCellWithReuseIdentifier: "videoMediaCollectionCellID")
        DispatchQueue.main.async {
            self.pictureCollection.reloadData()
            self.pictureCollection.collectionViewLayout.invalidateLayout()
            self.videoCollection.reloadData()
            self.videoCollection.collectionViewLayout.invalidateLayout()
        }
        for item in ACData.ANNOUNCEMENTLEVELLISTDATA {
            levelName.append(item.school_level)
        }
        if ACData.ANNOUNCEMENTCLASSDATA.count != 0 {
            classPickerButton.isUserInteractionEnabled = true
        } else {
            classPickerButton.isUserInteractionEnabled = false
        }
        if isEdit {
            saveNewEvent.setTitle("Save", for: .normal)
        } else {
            saveNewEvent.setTitle("Add", for: .normal)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfigEdit() {
        guard let obj = detailObjEdit else { return }
        for mediaObj in obj.medias {
            if mediaObj.media_type_id == "MT1" {
                videoArray.append(VideoMediaModel(fileID: mediaObj.media_id, fileURL: mediaObj.url, fileType: mediaObj.media_type_id))
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(videoArray) {
                    let defaults = UserDefaults.standard
                    defaults.set(encoded, forKey: "videoMediaSelected")
                }
            } else if mediaObj.media_type_id == "MT2" {
                galleryArray.append(GalleryMediaModel(fileID: mediaObj.media_id, fileURL: mediaObj.url, fileType: mediaObj.media_type_id))
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(galleryArray) {
                    let defaults = UserDefaults.standard
                    defaults.set(encoded, forKey: "galleryMediaSelected")
                }
            }
        }
        isEdit = true
        
        pictureCollection.reloadData()
        videoCollection.reloadData()
//        levelPickerButton.setTitle(obj.school_level_id, for: .normal)
//        classPickerButton.setTitle(obj.class, for: <#T##UIControl.State#>)
    }
    @objc func showPictGallery() {
        self.delegate?.openImageGallery()
    }
    @objc func showVideoGallery() {
        self.delegate?.openVideoGallery()
    }
    @objc func saveEvent() {
        self.delegate?.addNewEvent()
    }
    @objc func showLevelPicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Type -",
            rows: levelName,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.levelPickerButton.setTitle(value, for: .normal)
                self.levelID = ACData.ANNOUNCEMENTLEVELLISTDATA[indexes].school_level_id
                self.fetchClass(withLevel: value)
                self.delegate?.levelSelected(withValue: self.levelID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    func fetchClass(withLevel: String) {
        className.removeAll()
        ACData.ANNOUNCEMENTCLASSDATA.removeAll()
        ACRequest.GET_ANNOUNCEMENT_CLASS_DATA(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, levelID: levelID, accessToken: ACData.LOGINDATA.accessToken, successCompletion: { (classDatas) in
            ACData.ANNOUNCEMENTCLASSDATA = classDatas
            SVProgressHUD.dismiss()
            self.classPickerButton.isUserInteractionEnabled = true
            for item in ACData.ANNOUNCEMENTCLASSDATA {
                self.className.append(item.school_class)
            }
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    @objc func showClassPicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Type -",
            rows: className,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.classPickerButton.setTitle(value, for: .normal)
                self.classID = ACData.ANNOUNCEMENTCLASSDATA[indexes].school_class_id
                self.delegate?.classSelected(withValue: self.classID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
}

extension EditEventFooterCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == pictureCollection {
            if isEdit {
                return galleryArray.count
            } else {
                return ACData.ATTACHMENTIMAGEMEDIADATA.count
            }
        } else {
            if isEdit {
                return videoArray.count
            } else {
                return ACData.ATTACHMENTVIDEOMEDIADATA.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == pictureCollection {
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "imageMediaCollectionCellID", for: indexPath) as? ImageMediaCollectionCell)!
            if isEdit {
                cell.detailObj = galleryArray[indexPath.row]
            } else {
                cell.contentObj = ACData.ATTACHMENTIMAGEMEDIADATA[indexPath.row]
            }
            return cell
        } else {
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "videoMediaCollectionCellID", for: indexPath) as? VideoMediaCollectionCell)!
            if isEdit {
                cell.detailObj = videoArray[indexPath.row]
            } else {
                cell.contentObj = ACData.ATTACHMENTVIDEOMEDIADATA[indexPath.row]
            }
            return cell
        }
    }
}
