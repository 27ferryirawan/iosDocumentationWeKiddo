//
//  FeedbackViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 31/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class FeedbackViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var feedbackDescription = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Feedback", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "FeedbackCell", bundle: nil), forCellReuseIdentifier: "feedbackCellID")
    }
}

extension FeedbackViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "feedbackCellID", for: indexPath) as? FeedbackCell)!
        cell.delegate = self
        cell.feedbackDesc = self.feedbackDescription
        cell.attachmentCollection.reloadData()
        return cell
    }
}

extension FeedbackViewController: FeedbackCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func feedbackDescFilled(withString: String) {
        feedbackDescription = withString
    }
    func openAttachmentBanner() {
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
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func uploadAttachment(withImage: UIImage) {
        let parameter: Parameters = [
            "user_id": ACData.LOGINDATA.userID
        ]
        print(parameter)
        ACRequest.POST_UPLOAD_NEW_IMAGE_ATTACHMENT_FEEDBACK(parameters: parameter, file: withImage, fileName: "media_file", fileParameter: "media_file", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            ACData.ATTACHMENTIMAGEMEDIADATA = status
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
