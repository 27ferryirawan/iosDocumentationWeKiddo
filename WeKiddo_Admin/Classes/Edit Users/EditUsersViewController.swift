//
//  EditUsersViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 08/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class EditUsersViewController: UIViewController {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var imagePickedBase64 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Edit User", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "EditUsersCell", bundle: nil), forCellReuseIdentifier: "editUsersCellID")
        tableView.register(UINib(nibName: "EditUsersContentCell", bundle: nil), forCellReuseIdentifier: "editUsersContentCellID")
    }
}

extension EditUsersViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + ACData.USERSDETAILDATA.user_detail_assigned.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 692
        } else {
            return 55
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "editUsersCellID", for: indexPath) as? EditUsersCell)!
            if imagePickedBase64 != "" {
                cell.imageChoosen = imagePickedBase64
                let imageData = Data(base64Encoded: imagePickedBase64)
                let image = UIImage(data: imageData!)
                cell.avatarImage.image = image
            } else {
                cell.avatarImage.sd_setImage(
                    with: URL(string: (ACData.USERSDETAILDATA.user_detail_adminPhoto)),
                    placeholderImage: UIImage(named: "WeKiddoLogo"),
                    options: .refreshCached
                )
            }
            cell.detailObj = ACData.USERSDETAILDATA
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "editUsersContentCellID", for: indexPath) as? EditUsersContentCell)!
            return cell
        }
    }
}

extension EditUsersViewController: EditUsersCellDelegate {
    func showImageAttachment() {
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
}

extension EditUsersViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedParentImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        let newParentImage = selectedParentImage.resizeImage(30.0, opaque: false)
        let imageData = newParentImage.pngData()!
        let imageStr = imageData.base64EncodedString()
        self.imagePickedBase64 = imageStr
        //        self.imagePicked = newParentImage
        picker.dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.navigationController?.popViewController(animated: true)
    }
}
