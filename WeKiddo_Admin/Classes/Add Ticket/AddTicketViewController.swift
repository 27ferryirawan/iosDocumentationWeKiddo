//
//  AddTicketViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 04/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class AddTicketViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color: UIColor.groupTableViewBackground, shadowRadius: 3.0, shadowOpactiy: 1.0, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    var mediaIDArray = [TicketMediaModel]()
    var ticketTitle = ""
    var ticketType = ""
    var ticketDesc = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Add Ticket", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "AddTicketCell", bundle: nil), forCellReuseIdentifier: "addTicketCellID")
    }
}

extension AddTicketViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 398
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "addTicketCellID", for: indexPath) as? AddTicketCell)!
        cell.mediaArray = self.mediaIDArray
        if mediaIDArray.isEmpty {
            // do nothing
        } else {
            cell.detailObj = mediaIDArray[indexPath.row]
        }
        cell.delegate = self
        return cell
    }
}

extension AddTicketViewController: AddTicketCellDelegate {
    func titleFilledWithString(value: String) {
        ticketTitle = value
    }
    func typeFilledWithValue(value: String) {
        ticketType = value
    }
    func descriptionFilledWithValue(value: String) {
        ticketDesc = value
    }
    func saveNewTicket(withMediaArray: [TicketMediaModel]) {
        mediaIDArray = withMediaArray
        var mediaOn = "["
        var i = 0
        for data in mediaIDArray {
            if i > 0 {
                mediaOn += ","
            }
            mediaOn += "\(data.media_id)"
            
            i += 1
        }
        mediaOn += "]"
        
        let newaddOn = mediaOn.replacingOccurrences(of: "\\", with: "")
        let jsonData = newaddOn.data(using: .utf8)!
        let jsonO = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
        let parameters: Parameters = [
            "user_id":ACData.LOGINDATA.userID,
            "school_id":ACData.DASHBOARDDATA.home_profile_school_id,
            "year_id":ACData.DASHBOARDDATA.home_profile_year_id,
            "title":ticketTitle,
            "description":ticketDesc,
            "ticket_type":ticketType,
            "status":"1",
            "medias":jsonO
        ]
        print(parameters)
        ACRequest.POST_ADD_NEW_TICKET(params: parameters, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (result) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: result)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func openImageAttachment() {
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
}

extension AddTicketViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            let newImage = selectedImage.resizeImage(30.0, opaque: false)
            picker.dismiss(animated: true) {
                self.uploadAttachment(withImage: newImage)
            }
        } else {

        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func uploadAttachment(withImage: UIImage) {
        let parameter: Parameters = [
            "media_type": "MT7"
        ]

        ACRequest.POST_UPLOAD_NEW_ATTACHMENT_TICKET(parameters: parameter, file: withImage, fileName: "media_file", fileParameter: "media_file", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (result) in
            SVProgressHUD.dismiss()
            let jsonValue = JSON(result)
            self.mediaIDArray.append(TicketMediaModel(mediaID: jsonValue["data"]["media_file"]["id"].intValue, mediaURL: jsonValue["data"]["media_file"]["url"].stringValue))
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}
