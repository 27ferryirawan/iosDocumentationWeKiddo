//
//  AddStudentViewController.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 06/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
class AddStudentViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var schoolClassId : String?
    var schoolId : String?
    var schoolName :String?
    var selectedImage = UIImage(named: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configTable(){
        tableView.register(UINib(nibName: "AddStudentCell", bundle: nil), forCellReuseIdentifier: "addStudentCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Add Student", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Add Student", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
}
extension AddStudentViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 751
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "addStudentCell", for: indexPath) as? AddStudentCell)!
        cell.delegate = self
        if selectedImage != UIImage(named: ""){
            cell.profileImage.image = selectedImage
            cell.profileImageTap()
        } else {
            
        }
        cell.countryCode.parentViewController = self
        cell.schoolPickerBtn.setTitle(schoolName, for: .normal)
        return cell
    }
}
extension AddStudentViewController : AddStudentCellDelegate{
    func saveData(child_name: String, child_nis: String, child_address: String, child_phone: String, child_email: String, child_gender: String, child_bod: String, child_image: String, schoolId : String) {
        guard let yearId = ACData.LOGINDATA.dashboardSchoolMenu[0].year_id else {
            return
        }
        ACRequest.POST_SAVE_EDIT_STUDENT_DETAIL(userId: ACData.LOGINDATA.userID, schoolId: self.schoolId!, yearId: yearId, child_name: child_name, child_nis: child_nis, child_address: child_address, child_phone: child_phone, child_email: child_email, child_gender: child_gender, child_bod: child_bod, school_class_id: schoolClassId!, child_image: child_image, role_id: "2", childId: "", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            if status == "success" {
                ACAlert.show(message: "Successfully Add Student")
                UserDefaults.standard.removeObject(forKey: "AddStudentProfileImg")
            } else {
                ACAlert.show(message: "Failed Add Student")
            }
            SVProgressHUD.dismiss()
        }) { (failed) in
            SVProgressHUD.dismiss()
        }
    }
    
    func showAttachment() {
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
extension AddStudentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        let newImage = selectedImage.resizeImage(30.0, opaque: false)
        let imageData = newImage.pngData()!
        let imageStr = imageData.base64EncodedString()
        UserDefaults.standard.set(imageStr, forKey: "AddStudentProfileImg")
        UserDefaults.standard.synchronize()
        picker.dismiss(animated: true) {
            self.selectedImage = selectedImage
            self.tableView.reloadData()
        }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
        }
    }
}
