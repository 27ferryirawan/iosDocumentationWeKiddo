//
//  AddNewPermissionViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 08/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class AddNewPermissionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    var selectedDate = ""
    var selectedType = ""
    var reason = ""
    var selectedAttachment = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Permission", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "AddNewPermissionCell", bundle: nil), forCellReuseIdentifier: "addNewPermissionCellID")
    }
    @objc func showAttachmentPicker() {
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
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionsheet,animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    @objc func saveNewPermission() {
        ACRequest.POST_NEW_PERMISSION(child_id: ACData.HOMEDATA.childID, permission_date: selectedDate, permission_type: selectedType, permission_reason: reason, attachment: "", successCompletion: { (status) in
            if status == "success" {
                ACAlert.show(message: "Successfully add new permission")
            } else {
                print("fail")
            }
            SVProgressHUD.dismiss()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    @objc func discardPermission() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddNewPermissionViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 606
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "addNewPermissionCellID", for: indexPath) as? AddNewPermissionCell)!
        cell.delegate = self
        cell.selectAttachmentButton.addTarget(self, action: #selector(showAttachmentPicker), for: .touchUpInside)
        cell.saveButton.addTarget(self, action: #selector(saveNewPermission), for: .touchUpInside)
        cell.discardButton.addTarget(self, action: #selector(discardPermission), for: .touchUpInside)
        return cell
    }
}

extension AddNewPermissionViewController: AddNewPermissionCellDelegate {
    func dateSelected(date: String) {
        print(date)
        selectedDate = date
    }
    
    func typeSelected(type: String) {
        print(type)
        if type == "Sick" {
            selectedType = "1"
        } else {
            selectedType = "2"
        }
    }
    
    func reasonFilled(reason: String) {
        print(reason)
        self.reason = reason
    }
}
