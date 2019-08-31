//
//  AddAnnouncementHeaderCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 10/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import SVProgressHUD

protocol AddAnnouncementHeaderCellDelegate: class {
    func addMoreDesc()
    func openImageGallery()
    func openVideoGallery()
    func levelSelected(withValue: String)
    func classSelected(withValue: String)
    func toSearchStudentPage(withStudentsLists: [StudentSearchSelected])
    func addAnnouncement()
    func didTapStudent(with obj: StudentSearchSelected)
}

class AddAnnouncementHeaderCell: UITableViewCell {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var studentCollection: UICollectionView!
    @IBOutlet weak var addStudentButton: UIButton!
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
    weak var delegate: AddAnnouncementHeaderCellDelegate?
    var levelName = [String]()
    var className = [String]()
    var levelID = ""
    var classID = ""
    var isFromEdit : Bool = false
    var studentLists = [StudentSearchSelected]()
    override func awakeFromNib() {
        super.awakeFromNib()
        addMoreDescButton.addTarget(self, action: #selector(addDesc), for: .touchUpInside)
        addPictButton.addTarget(self, action: #selector(showPictGallery), for: .touchUpInside)
        addVideoButton.addTarget(self, action: #selector(showVideoGallery), for: .touchUpInside)
        levelPickerButton.addTarget(self, action: #selector(showLevelPicker), for: .touchUpInside)
        classPickerButton.addTarget(self, action: #selector(showClassPicker), for: .touchUpInside)
        addStudentButton.addTarget(self, action: #selector(showStudentPage), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        pictureCollection.register(UINib(nibName: "ImageMediaCollectionCell", bundle: nil), forCellWithReuseIdentifier: "imageMediaCollectionCellID")
        videoCollection.register(UINib(nibName: "VideoMediaCollectionCell", bundle: nil), forCellWithReuseIdentifier: "videoMediaCollectionCellID")
        studentCollection.register(UINib(nibName: "AddStudentCollectionCell", bundle: nil), forCellWithReuseIdentifier: "addStudentCollectionCellID")
        DispatchQueue.main.async {
            self.pictureCollection.reloadData()
            self.pictureCollection.collectionViewLayout.invalidateLayout()
            self.videoCollection.reloadData()
            self.videoCollection.collectionViewLayout.invalidateLayout()
            self.studentCollection.reloadData()
            self.studentCollection.collectionViewLayout.invalidateLayout()
        }
        for item in ACData.ANNOUNCEMENTLEVELLISTDATA {
            levelName.append(item.school_level)
        }
        if ACData.ANNOUNCEMENTCLASSDATA.count != 0 {
            classPickerButton.isUserInteractionEnabled = true
        } else {
            classPickerButton.isUserInteractionEnabled = false
        }

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func showPictGallery() {
        self.delegate?.openImageGallery()
    }
    @objc func showVideoGallery() {
        self.delegate?.openVideoGallery()
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
        //TODO: Change Value of schoolID and yearID
        ACRequest.GET_ANNOUNCEMENT_CLASS_DATA(
            userID: ACData.LOGINDATA.userID,
            schoolID: ACData.LOGINDATA.dashboardSchoolMenu.last?.school_id ?? "",
            yearID: ACData.LOGINDATA.dashboardSchoolMenu.last?.year_id ?? "",
            levelID: levelID,
            accessToken: ACData.LOGINDATA.accessToken, successCompletion: { (classDatas) in
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
    @objc func showStudentPage() {
        self.delegate?.toSearchStudentPage(withStudentsLists: studentLists)
    }
    @objc func addAction() {
        self.delegate?.addAnnouncement()
    }
    @objc func addDesc() {
        self.delegate?.addMoreDesc()
    }
}

extension AddAnnouncementHeaderCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == pictureCollection {
            return ACData.ATTACHMENTIMAGEMEDIADATA.count
        } else if collectionView == videoCollection {
            return ACData.ATTACHMENTVIDEOMEDIADATA.count
        } else {
            // TODO: replace with student collection data later on
            return studentLists.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == pictureCollection {
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "imageMediaCollectionCellID", for: indexPath) as? ImageMediaCollectionCell)!
            cell.contentObj = ACData.ATTACHMENTIMAGEMEDIADATA[indexPath.row]
            return cell
        } else if collectionView == videoCollection {
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "videoMediaCollectionCellID", for: indexPath) as? VideoMediaCollectionCell)!
            cell.contentObj = ACData.ATTACHMENTVIDEOMEDIADATA[indexPath.row]
            return cell
        } else {
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "addStudentCollectionCellID", for: indexPath) as? AddStudentCollectionCell)!
            cell.objDetail = studentLists[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isFromEdit{
            let obj = studentLists[indexPath.row]
            delegate?.didTapStudent(with: obj)
        }
    }
}
