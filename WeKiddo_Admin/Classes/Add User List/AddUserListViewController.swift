//
//  AddUserListViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 06/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import SVProgressHUD

class AddUserListViewController: UIViewController {

    @IBOutlet weak var submitNewClassButton: UIButton!
    @IBOutlet weak var selectClassButton: UIButton! {
        didSet {
            selectClassButton.layer.borderWidth = 1.0
            selectClassButton.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        }
    }
    @IBOutlet weak var selectSubjectButton: UIButton! {
        didSet {
            selectSubjectButton.layer.borderWidth = 1.0
            selectSubjectButton.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        }
    }
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var addNewView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var imagePicked = UIImage()
    var subjectArray = [String]()
    var classArray = [String]()
    var selectedSubject = ""
    var selectedClass = "'"
    var schoolID = ""
    var year_id = ""
    var name = ""
    var nip = ""
    var address = ""
    var phoneCode = ""
    var phoneNumber = ""
    var email = ""
    var gender = ""
    var position = ""
    var classID = ""
    var subjectID = ""
    var class_id = ""
    var isAddNewViewDisplayed = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        updateView()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Add User", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "AddUserListCell", bundle: nil), forCellReuseIdentifier: "addUserListCellID")
        tableView.register(UINib(nibName: "AddUserSubjectClassCell", bundle: nil), forCellReuseIdentifier: "addUserSubjectClassCellID")
        closeButton.addTarget(self, action: #selector(closeAddView), for: .touchUpInside)
        selectSubjectButton.addTarget(self, action: #selector(showSubjectPicker), for: .touchUpInside)
        selectClassButton.addTarget(self, action: #selector(showClassPicker), for: .touchUpInside)
        submitNewClassButton.addTarget(self, action: #selector(submitNewClass), for: .touchUpInside)
    }
    func updateView() {
        if isAddNewViewDisplayed {
            addNewView.isHidden = false
        } else {
            addNewView.isHidden = true
        }
    }
    @objc func closeAddView() {
        isAddNewViewDisplayed = false
        updateView()
    }
    @objc func showSubjectPicker() {
        subjectArray.removeAll()
        for subjectItem in ACData.USERLISTPARAMDATA.subject_list {
            subjectArray.append(subjectItem.subject_name)
        }
        ActionSheetStringPicker.show(
            withTitle: "- Select Type -",
            rows: subjectArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.selectSubjectButton.setTitle(value, for: .normal)
                let subjectid = ACData.USERLISTPARAMDATA.subject_list[indexes].subject_id
                self.subjectID = subjectid
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func showClassPicker() {
        classArray.removeAll()
        for classItem in ACData.USERLISTPARAMDATA.class_list {
            classArray.append(classItem.school_class)
        }
        ActionSheetStringPicker.show(
            withTitle: "- Select Type -",
            rows: classArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.selectClassButton.setTitle(value, for: .normal)
                let classid = ACData.USERLISTPARAMDATA.class_list[indexes].school_class_id
                self.class_id = classid
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func submitNewClass() {
        ACRequest.POST_USER_SCHOOL_ADD_NEW_SUBJECT(userId: ACData.LOGINDATA.userID, schoolID: schoolID, yearID: ACData.DASHBOARDDATA.home_profile_year_id, schoolUserID: "", subjectID: subjectID, schoolClassID: self.class_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
            ACData.SAVESUBJECTNEWDATA = results
            SVProgressHUD.dismiss()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}

extension AddUserListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + ACData.SAVESUBJECTNEWDATA.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 805
        } else {
            return 44
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addUserListCellID", for: indexPath) as? AddUserListCell)!
            cell.imagePhoto = self.imagePicked
            cell.obj = ACData.USERLISTPARAMDATA
            cell.imageCollection.reloadData()
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addUserSubjectClassCellID", for: indexPath) as? AddUserSubjectClassCell)!
            if ACData.SAVESUBJECTNEWDATA.count != 0 {
                cell.detailObj = ACData.SAVESUBJECTNEWDATA[indexPath.row - 1]
            } else {
                
            }
            cell.schoolID = schoolID
            cell.delegate = self
            return cell
        }
    }
}

extension AddUserListViewController: AddUserListCellDelegate, AddUserSubjectClassCellDelegate {
    func refreshData() {
        self.tableView.reloadData()
    }
    func schoolSelectedWith(value: String, yearID: String, withTeacherID: String) {
        schoolID = value
        year_id = yearID
    }
    func nameFilledWith(value: String) {
        name = value
    }
    
    func nipFilledWith(value: String) {
        nip = value
    }
    
    func addressFilledWith(value: String) {
        address = value
    }
    
    func phoneCountryCodeFilledWith(value: String) {
        phoneCode = value
    }
    
    func phoneNumberFilledWith(value: String) {
        phoneNumber = value
    }
    
    func emailFilledWith(value: String) {
        email = value
    }
    
    func genderSelectedWith(value: String) {
        gender = value
    }
    
    func positionSelectedWith(value: String) {
        position = value
    }
    
    func classSelectedWith(value: String) {
        classID = value
    }
    func showAddNewView() {
        isAddNewViewDisplayed = true
        updateView()
    }
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

extension AddUserListViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedParentImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        let newParentImage = selectedParentImage.resizeImage(30.0, opaque: false)
        self.imagePicked = newParentImage
//        let parentImageData = newParentImage.pngData()!
//        let parentImageStr = parentImageData.base64EncodedString()
        
//        UserDefaults.standard.set(parentImageStr, forKey: "SelectedImageFile")
//        UserDefaults.standard.synchronize()
        
        picker.dismiss(animated: true) {
            self.tableView.reloadData()
//            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.navigationController?.popViewController(animated: true)
    }
}
