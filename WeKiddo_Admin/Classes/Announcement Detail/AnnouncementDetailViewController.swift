//
//  AnnouncementDetailViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 21/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class AnnouncementDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var mediaArray = [AnnouncementDetailMediasModel]()
    var videoArray = [AnnouncementDetailMediasModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        print("tuki: \(ACData.ANNOUNCEMENTDETAILDATA.field.count)")
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Announcement", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "AnnouncementDetailCell", bundle: nil), forCellReuseIdentifier: "announcementDetailCell")
        tableView.register(UINib(nibName: "TitleDescriptionCell", bundle: nil), forCellReuseIdentifier: "titleDescriptionCell")
        tableView.register(UINib(nibName: "AnnouncementDetailFooterCell", bundle: nil), forCellReuseIdentifier: "announcementDetailFooterCellID")
    }
    func populateData() {
        for mediaObj in ACData.ANNOUNCEMENTDETAILDATA.medias {
            if mediaObj.media_type_id == "MT1" {
                videoArray.append(mediaObj)
            }
        }
        for mediaObj in ACData.ANNOUNCEMENTDETAILDATA.medias {
            if mediaObj.media_type_id == "MT2" {
                mediaArray.append(mediaObj)
            }
        }
    }
}

extension AnnouncementDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + ACData.ANNOUNCEMENTDETAILDATA.field.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 423
        } else if indexPath.row == ACData.ANNOUNCEMENTDETAILDATA.field.count + 1 {
            return 360
        } else {
            return 52   
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = (tableView.dequeueReusableCell(withIdentifier: "announcementDetailCell", for: indexPath) as? AnnouncementDetailCell)!
            cell.detailObj = ACData.ANNOUNCEMENTDETAILDATA
            cell.delegate = self
            return cell
        } else if indexPath.row == ACData.ANNOUNCEMENTDETAILDATA.field.count + 1 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "announcementDetailFooterCellID", for: indexPath) as? AnnouncementDetailFooterCell)!
            cell.mediaArray = self.mediaArray
            cell.videoArray = self.videoArray
            cell.detailObj = ACData.ANNOUNCEMENTDETAILDATA
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "titleDescriptionCell", for: indexPath) as? TitleDescriptionCell)!
            cell.fieldObj = ACData.ANNOUNCEMENTDETAILDATA.field[indexPath.row-1]
            return cell
        }
    }
}

extension AnnouncementDetailViewController: AnnouncementDetailCellDelegate, AnnouncementDetailFooterDelegate {
    func previewImage(withImageURL: String) {
        let previewVC = ImagePreviewViewController()
        previewVC.imageURL = withImageURL
        previewVC.isPreviewImage = true
        self.navigationController?.present(previewVC, animated: true, completion: nil)
    }
    func playVideo(withURL: String) {
        let preview = ImagePreviewViewController()
        preview.isPreviewImage = false
        preview.imageURL = withURL
        self.navigationController?.present(preview, animated: true, completion: nil)
    }
    func toEditAnnouncementPage() {
        let editAnncVC = AddAnnouncementViewController()
        editAnncVC.isFromEdit = true
        self.navigationController?.pushViewController(editAnncVC, animated: true)
    }
}
