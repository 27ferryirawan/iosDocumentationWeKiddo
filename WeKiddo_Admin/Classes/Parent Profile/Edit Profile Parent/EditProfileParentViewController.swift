//
//  EditProfileParentViewController.swift
//  WeKiddo
//
//  Created by zein rezky chandra on 19/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD
import ActionSheetPicker_3_0

protocol EditProfileParentViewControllerDelegate: class {
    func refreshData()
}

class EditProfileParentViewController: UIViewController {

    @IBOutlet weak var selectSubmitButton: UIButton! {
        didSet {
            selectSubmitButton.layer.cornerRadius = 5.0
            selectSubmitButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var selectClassButton: UIButton! {
        didSet {
            selectClassButton.layer.cornerRadius = 5.0
            selectClassButton.layer.borderWidth = 0.5
            selectClassButton.layer.borderColor = UIColor.lightGray.cgColor
            selectClassButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var selectSubjectButton: UIButton! {
        didSet {
            selectSubjectButton.layer.cornerRadius = 5.0
            selectSubjectButton.layer.borderWidth = 0.5
            selectSubjectButton.layer.borderColor = UIColor.lightGray.cgColor
            selectSubjectButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var closeAddNewSubjectButton: UIButton!
    @IBOutlet weak var addNewSubjectView: UIView! {
        didSet {
            addNewSubjectView.setBorderShadow(color: UIColor.gray, shadowRadius: 2.0, shadowOpactiy: 0.5, shadowOffsetWidth: 2, shadowOffsetHeight: 2)
        }
    }
    @IBOutlet weak var tableViuew: UITableView!
    var isAutoRefresh = false
    var isAddNewSubjectView = false
    var subjectCount = 0
    var subjectArray = [String]()
    var classArray = [String]()
    var subjectID = ""
    var schoolClassID = ""
    var updatedAddress = ""
    var updatedEmail = ""
    var updatedTelphone = ""
    var updatedPosition = ""
    weak var delegate: EditProfileParentViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        configNavigation()
        fetchData()
        updateAndPopulateView()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.delegate?.refreshData()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Edit Profile", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        tableViuew.register(UINib(nibName: "EditProfileParentCell", bundle: nil), forCellReuseIdentifier: "editProfileParentCell")
        tableViuew.register(UINib(nibName: "EditProfileSubjectCell", bundle: nil), forCellReuseIdentifier: "editProfileSubjectCellID")
        tableViuew.register(UINib(nibName: "EditProfileFooterCell", bundle: nil), forCellReuseIdentifier: "editProfileFooterCellID")
        
        selectSubjectButton.addTarget(self, action: #selector(showSubjectPicker), for: .touchUpInside)
        selectClassButton.addTarget(self, action: #selector(showClassPicker), for: .touchUpInside)
        closeAddNewSubjectButton.addTarget(self, action: #selector(closeAddView), for: .touchUpInside)
        selectSubmitButton.addTarget(self, action: #selector(submitNewSubject), for: .touchUpInside)
    }
    func fetchData() {
        ACRequest.POST_TEACHER_PROFILE(userId: ACData.LOGINDATA.userID, schoolID: ACData.LOGINDATA.school_id, role: ACData.LOGINDATA.role, yearID: ACData.LOGINDATA.year_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (profileData) in
            ACData.PARENTPROFILEDATA = profileData
            SVProgressHUD.dismiss()
            self.subjectCount = ACData.PARENTPROFILEDATA.subject_class.count
            self.isAddNewSubjectView = false
            self.updateAndPopulateView()
            self.tableViuew.setContentOffset(.zero, animated: true)
            self.tableViuew.reloadData()
            self.tableViuew.layoutIfNeeded()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    @objc func submitNewSubject() {
        ACRequest.POST_ADD_NEW_SUBJECT_EDIT_PROFILE(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, subjectID: self.subjectID, schoolClassID: self.schoolClassID, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            self.fetchData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    @objc func showSubjectPicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Subject -",
            rows: subjectArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.selectSubjectButton.setTitle(value, for: .normal)
                self.subjectID = ACData.PARENTPROFILEDATA.subject_list[indexes].subject_id
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func showClassPicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Class -",
            rows: classArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.selectClassButton.setTitle(value, for: .normal)
                self.schoolClassID = ACData.PARENTPROFILEDATA.class_list[indexes].school_class_id
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func closeAddView() {
        isAddNewSubjectView = false
        updateAndPopulateView()
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.tableViuew.frame.origin.y == 0 {
                self.tableViuew.frame.origin.y -= keyboardSize.height
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.tableViuew.frame.origin.y != 0 {
            self.tableViuew.frame.origin.y = 0
        }
    }
    func updateAndPopulateView() {
        subjectArray.removeAll()
        classArray.removeAll()
        if isAddNewSubjectView {
            addNewSubjectView.isHidden = false
            isAddNewSubjectView = false
            for item in ACData.PARENTPROFILEDATA.subject_list {
                subjectArray.append(item.subject_name)
            }
            for itemClass in ACData.PARENTPROFILEDATA.class_list {
                classArray.append(itemClass.school_class)
            }
        } else {
            addNewSubjectView.isHidden = true
            isAddNewSubjectView = true
        }
    }
}

extension EditProfileParentViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + subjectCount
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 678
        } else {
            return 44
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "editProfileParentCell", for: indexPath) as? EditProfileParentCell)!
            cell.detailObj = ACData.PARENTPROFILEDATA
            cell.delegate = self
            return cell
        } else {
            if indexPath.row != 1 + subjectCount {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "editProfileSubjectCellID", for: indexPath) as? EditProfileSubjectCell)!
                cell.detailObj = ACData.PARENTPROFILEDATA.subject_class[indexPath.row - 1]
                cell.delegate = self
                return cell
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "editProfileFooterCellID", for: indexPath) as? EditProfileFooterCell)!
                cell.address = updatedAddress
                cell.telphone = updatedTelphone
                cell.email = updatedEmail
                cell.position = updatedPosition
                return cell
            }
        }
    }
}

extension EditProfileParentViewController: EditProfileParentDelegate, OTPViewControllerDelegate, EditProfileSubjectCellDelegate, EditProfileFooterCellDelegate {
    func autoRefreshPrevActivity() {
        fetchData()
    }
    func deleteAction() {
        fetchData()
    }
    func editProfileFinish(withMessage: String) {
        ACAlert.show(message: withMessage)
        fetchData()
    }
    func dismisView() {
        self.navigationController?.popViewController(animated: true)
    }
    func displayAddSubjectView() {
        isAddNewSubjectView = true
        updateAndPopulateView()
    }
    func addressFieldFilled(withAddress: String) {
        print("address: \(withAddress)")
        updatedAddress = withAddress
    }
    func phoneFilled(withString: String) {
        print("Phone: \(withString)")
        updatedTelphone = withString
    }
    func emailFilled(withEmail: String) {
        print("Email: \(withEmail)")
        updatedEmail = withEmail
    }
    func positionFilled(withID: String) {
        print("position index: \(withID)")
        updatedPosition = withID
    }
    func showImagePicker() {
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
    func requestOTPVerification(parentID: String, parentName: String, parentPhone: String, parentEmail: String, parentAddress: String, parentOccupation: String, parentCompany: String, parentPosition: String, parentImage: String){
        let phone = "+\(parentPhone)"
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            let defaults = UserDefaults.standard
            defaults.set(verificationID, forKey: "authVID")
            
            let otpVC = OTPViewController()
            otpVC.phone = phone
            otpVC.fromEditProfile = true
            otpVC.delegate = self

            self.navigationController?.pushViewController(otpVC, animated: true)
        }
    }
}
extension EditProfileParentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedParentImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        let newParentImage = selectedParentImage.resizeImage(30.0, opaque: false)
        let parentImageData = newParentImage.pngData()!
        let parentImageStr = parentImageData.base64EncodedString()

        UserDefaults.standard.set(parentImageStr, forKey: "SelectedImageFile")
        UserDefaults.standard.synchronize()
        
        picker.dismiss(animated: true) {
            self.tableViuew.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.navigationController?.popViewController(animated: true)
    }
}
