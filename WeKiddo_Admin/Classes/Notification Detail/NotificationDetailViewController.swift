//
//  NotificationDetailViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 17/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SVProgressHUD

class NotificationDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var isApproval = false
    var mediaArray = [ApprovalDetailMediaModel]()
    var videoArray = [ApprovalDetailMediaModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        populateData()
        configTable()
        print(isApproval)
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Event Approval Detail", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Event Approval Detail", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "NotificationHeaderGalleryCell", bundle: nil), forCellReuseIdentifier: "notificationDetailCell")
        tableView.register(UINib(nibName: "ApprovalTitleDescriptionCell", bundle: nil), forCellReuseIdentifier: "approvalTitleDescriptionCellID")
        tableView.register(UINib(nibName: "ApprovalDetailFooterCell", bundle: nil), forCellReuseIdentifier: "approvalDetailFooterCellID")
        tableView.register(UINib(nibName: "EventMonitoringTotalParticipantCell", bundle: nil), forCellReuseIdentifier: "eventMonitoringTotalParticipantCellID")
        tableView.dataSource = self
        tableView.delegate = self
    }
    func populateData() {
        for mediaObj in ACData.APPROVALDETAILDATA.medias {
            if mediaObj.media_type_id == "MT1" {
                videoArray.append(mediaObj)
            }
        }
        for mediaObj in ACData.APPROVALDETAILDATA.medias {
            if mediaObj.media_type_id == "MT2" {
                mediaArray.append(mediaObj)
            }
        }
    }
}

extension NotificationDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 + ACData.APPROVALDETAILDATA.field.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 510
        } else if indexPath.row < 1 + ACData.APPROVALDETAILDATA.field.count {
            return 70
        } else if indexPath.row == 1 + ACData.APPROVALDETAILDATA.field.count {
            return 230
        } else {
            return 346
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "notificationDetailCell", for: indexPath) as? NotificationHeaderGalleryCell)!
            cell.detailObj = ACData.APPROVALDETAILDATA
            cell.delegate = self
            return cell
        }  else if indexPath.row < 1 + ACData.APPROVALDETAILDATA.field.count {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "approvalTitleDescriptionCellID", for: indexPath) as? ApprovalTitleDescriptionCell)!
            if ACData.APPROVALDETAILDATA.field.count != 0 {
                cell.detailObj = ACData.APPROVALDETAILDATA.field[indexPath.row-1]
            } else {
                // do nothing
            }
            return cell
        } else if indexPath.row == 1 + ACData.APPROVALDETAILDATA.field.count {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "approvalDetailFooterCellID", for: indexPath) as? ApprovalDetailFooterCell)!
            cell.mediaArray = self.mediaArray
            cell.videoArray = self.videoArray
            cell.detailObj = ACData.APPROVALDETAILDATA
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "eventMonitoringTotalParticipantCellID", for: indexPath) as? EventMonitoringTotalParticipantCell)!
            cell.detailObj = ACData.APPROVALDETAILDATA
            cell.delegate = self
            return cell
        }
    }
}

extension NotificationDetailViewController: NotificationHeaderCellDelegate, ApprovalDetailFooterCellDelegate, EventMonitoringTotalParticipantCellDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func openMap(lat: Double, long: Double, placeName: String) {
        let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long)))
        source.name = placeName
        MKMapItem.openMaps(with: [source], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
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
    func refreshData() {
        tableView.reloadRows(at: [IndexPath(row: 2 + ACData.APPROVALDETAILDATA.field.count, section: 0)], with: UITableView.RowAnimation.none)
    }
    func uploadFile() {
        openPicker()
    }
    func toPaymentPage() {
        let paymentVC = EditPaymentViewController()
        self.navigationController?.pushViewController(paymentVC, animated: true)
    }
    func toEditEvent() {
        ACData.ANNOUNCEMENTLEVELLISTDATA.removeAll()
        ACRequest.GET_ANNOUNCEMENT_LEVEL_DATA(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, accessToken: ACData.LOGINDATA.accessToken, successCompletion: { (levelDatas) in
            SVProgressHUD.dismiss()
            ACData.ANNOUNCEMENTLEVELLISTDATA = levelDatas
            let editVC = EditEventMonitoringViewController()
            editVC.isEdit = true
            self.navigationController?.pushViewController(editVC, animated: true)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func openPicker() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionsheet = UIAlertController(title: "Browse Attachment", message: "Choose A Source", preferredStyle: .alert)
        actionsheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction)in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("Camera is Not Available")
            }
        }))
        actionsheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction)in
            imagePickerController.sourceType = .savedPhotosAlbum
            imagePickerController.mediaTypes = ["public.image", "public.movie"]
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionsheet,animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            let newImage = selectedImage.resizeImage(30.0, opaque: false)
            picker.dismiss(animated: true) {
                self.uploadAttachment(withImage: newImage)
            }
        } else if let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            do {
                let data = try Data(contentsOf: videoUrl, options: .mappedIfSafe)
                print(data)
                picker.dismiss(animated: true) {
                    self.uploadVideo(withURL: data)
                }
            } catch  {
                
            }
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func uploadVideo(withURL: Data) {
        let parameter: Parameters = [
            "user_id": ACData.LOGINDATA.userID,
            "role": ACData.LOGINDATA.role,
            "school_id": ACData.LOGINDATA.school_id,
            "year_id": ACData.LOGINDATA.year_id,
            "media_type": "MT1",
            "event_id": ACData.APPROVALDETAILDATA.event_id
        ]
        print(parameter)
        ACRequest.POST_UPLOAD_NEW_VIDEO_ATTACHMENT_EVENT_MONITORING(parameters: parameter, file: withURL, fileName: "media_file", fileParameter: "media_file", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            ACData.ATTACHMENTVIDEOMEDIADATA = status
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func uploadAttachment(withImage: UIImage) {
        let parameter: Parameters = [
            "user_id": ACData.LOGINDATA.userID,
            "role": ACData.LOGINDATA.role,
            "school_id": ACData.LOGINDATA.school_id,
            "year_id": ACData.LOGINDATA.year_id,
            "media_type": "MT7",
            "event_id": ACData.APPROVALDETAILDATA.event_id
        ]
        print(parameter)
        ACRequest.POST_UPLOAD_NEW_IMAGE_ATTACHMENT_EVENT_MONITORING(parameters: parameter, file: withImage, fileName: "media_file", fileParameter: "media_file", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            ACData.ATTACHMENTBANNERDATA = status
            SVProgressHUD.dismiss()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}
