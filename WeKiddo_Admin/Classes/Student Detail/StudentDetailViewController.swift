//
//  StudentDetailViewController.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 04/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import SVProgressHUD
import FlagPhoneNumber

class StudentDetailViewController: UIViewController {

    var selectedParentId = ""
    var tempCountryCode = ""
    var schoolId:String?
    var genderList = ["Male","Female"]
    var maleFemale = ""
    var relationList = ["Father","Mother","Guardian"]
    var pickedRelation = ""
    var imageString = ""
    @IBOutlet weak var closeAddParentBtn: UIButton!
    @IBOutlet weak var grayAreaBtn: UIButton!{
        didSet{
            grayAreaBtn.isHidden = true
            grayAreaBtn.backgroundColor = UIColor(displayP3Red: 102/255, green: 102/255, blue: 102/255, alpha: 0.8)
        }
    }
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var editStudentBtn: UIButton!
    @IBOutlet weak var terminateStudentBtn: UIButton!
    @IBOutlet weak var popUpHeader: UILabel!{
        didSet{
            popUpHeader.backgroundColor = .clear
        }
    }
    @IBOutlet weak var popUpView: UIView!{
        didSet{
            popUpView.isHidden = true
            popUpView.layer.borderWidth = 1
            popUpView.layer.borderColor = UIColor(hex: "#D3D3D3").cgColor
        }
    }
    @IBOutlet weak var profileImage: UIImageView!{
        didSet{
            profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        }
    }
    @IBOutlet weak var childName: UILabel!
    @IBOutlet weak var childNIS: UILabel!
    @IBOutlet weak var datePicker: ButtonLeftSpace!{
        didSet{
            datePicker.setTitleColor(.black, for: .normal)
        }
    }
    @IBOutlet weak var reasonTextView: UITextView!
    
    @IBOutlet weak var yesBtn: UIButton!{
        didSet{
            yesBtn.layer.cornerRadius = 5
        }
    }
    @objc func showTerminatePopUp(){
        reasonTextView.text = ""
        datePicker.setTitle("- Select Date -", for: .normal)
        popUpView.isHidden = false
        grayAreaBtn.isHidden = false
        terminateStudentBtn.alpha = 0.5
        editStudentBtn.alpha = 0.5
    }
    @objc func closeTerminatePopUp(){
        popUpView.isHidden = true
        grayAreaBtn.isHidden = true
        terminateStudentBtn.alpha = 1
        editStudentBtn.alpha = 1
    }
    @IBOutlet weak var cancelBtn: UIButton!{
        didSet{
            cancelBtn.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var deleteImgBtn: UIButton!
    @IBOutlet weak var addParentLbl: UILabel!
    @IBOutlet weak var parentNameTextField: TextFieldSpace!
    @IBOutlet weak var parentImage: UIImageView!{
        didSet{
            parentImage.image = UIImage(named: "plus")
            parentImage.layer.cornerRadius = parentImage.frame.size.width/2
        }
    }
    @IBOutlet weak var relationPicker: ButtonLeftSpace!
    @IBOutlet weak var countryCode: FPNTextField!{
        didSet{
            countryCode.hasPhoneNumberExample = false
            countryCode.placeholder = ""
        }
    }
    @IBOutlet weak var phoneNumbTextField: TextFieldSpace!
    @IBOutlet weak var addressTextField: TextFieldSpace!
    @IBOutlet weak var emailTextField: TextFieldSpace!
    @IBOutlet weak var genderPicker: ButtonLeftSpace!
    @IBOutlet weak var addParentBtn: UIButton!
    @IBOutlet weak var addParentView: UIView!{
        didSet{
            addParentView.isHidden = true
            addParentView.layer.borderWidth = 1
            addParentView.layer.borderColor = UIColor(hex: "#D3D3D3").cgColor
        }
    }
    func showAddStudentPopUp(){
        parentNameTextField.text = ""
        parentNameTextField.placeholder = "Name"
        relationPicker.setTitle("Relation", for: .normal)
        relationPicker.addTarget(self, action: #selector(showRelationPicker), for: .touchUpInside)
        let locale = Locale.current
        guard let currentCode = locale.regionCode else { return }
        countryCode.setFlag(for: FPNCountryCode.init(rawValue: currentCode)!)
        countryCode.delegate = self
        countryCode.parentViewController = self
        phoneNumbTextField.text = ""
        phoneNumbTextField.placeholder = "Phone No"
        addressTextField.text = ""
        addressTextField.placeholder = "Address"
        emailTextField.text = ""
        emailTextField.placeholder = "Email"
        genderPicker.setTitle("Gender", for: .normal)
        genderPicker.addTarget(self, action: #selector(showGenderPicker), for: .touchUpInside)
        closeAddParentBtn.addTarget(self, action: #selector(closeAddStudentPopUp), for: .touchUpInside)
        grayAreaBtn.addTarget(self, action: #selector(closeAddStudentPopUp), for: .touchUpInside)
        grayAreaBtn.isHidden = false
        addParentView.isHidden = false
        terminateStudentBtn.alpha = 0.5
        editStudentBtn.alpha = 0.5
        headerLbl.text = "Add Parent"
        addParentBtn.setTitle("Add", for: .normal)
        profileImageTap()
    }
    @objc func closeAddStudentPopUp(){
        addParentView.isHidden = true
        grayAreaBtn.isHidden = true
        terminateStudentBtn.alpha = 1
        editStudentBtn.alpha = 1
        UserDefaults.standard.removeObject(forKey: "AddParentProfileImg")
    }
    
    func showEditStudentPopUp(parentName:String, parentImage:String, parentRelation:String, parentPhone:String, parentAddress:String, parentEmail:String, parentGender:String){
        parentNameTextField.text = parentName
        relationPicker.addTarget(self, action: #selector(showRelationPicker), for: .touchUpInside)
        relationPicker.setTitle(parentRelation, for: .normal)
        if "+\(parentPhone.prefix(2))" == "+62"{
            countryCode.setFlag(for: FPNCountryCode.ID)
            tempCountryCode = "62"
        }
        countryCode.delegate = self
        countryCode.parentViewController = self
        phoneNumbTextField.text = "\(parentPhone.suffix(parentPhone.count-2))"
        self.parentImage.sd_setImage(
            with: URL(string: (parentImage)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        addressTextField.text = parentAddress
        emailTextField.text = parentEmail
        genderPicker.addTarget(self, action: #selector(showGenderPicker), for: .touchUpInside)
        genderPicker.setTitle(parentGender, for: .normal)
        closeAddParentBtn.addTarget(self, action: #selector(closeAddStudentPopUp), for: .touchUpInside)
        grayAreaBtn.addTarget(self, action: #selector(closeAddStudentPopUp), for: .touchUpInside)
        grayAreaBtn.isHidden = false
        addParentView.isHidden = false
        terminateStudentBtn.alpha = 0.5
        editStudentBtn.alpha = 0.5
        profileImageTap()
        headerLbl.text = "Edit Parent"
        addParentBtn.setTitle("Save", for: .normal)
    }
    @objc func closeEditStudentPopUp(){
        addParentView.isHidden = true
        grayAreaBtn.isHidden = true
        terminateStudentBtn.alpha = 1
        editStudentBtn.alpha = 1
        UserDefaults.standard.removeObject(forKey: "AddParentProfileImg")
    }
    @objc func addParent(){
        guard let obj = ACData.CLASSROOMSTUDENTDETAILDATA  else { return }
        guard let yearId = ACData.LOGINDATA.dashboardSchoolMenu[0].year_id else {
            return
        }
        if let dataImage = UserDefaults.standard.string(forKey: "AddParentProfileImg") {
            self.imageString = "data:image/png;base64,\(dataImage)"
        }
        let fullPhone = "\(tempCountryCode)\(phoneNumbTextField.text!)"
        ACRequest.POST_CLASSROOM_STUDENT_ADD_PARENT(user_id: ACData.LOGINDATA.userID, school_id: schoolId!, year_id: yearId, child_id: obj.child_id, parent_name: parentNameTextField.text!, parent_phone: fullPhone, gender: maleFemale, parent_type: "1", parent_address: addressTextField.text! , parent_email: emailTextField.text!, parent_id: "", parent_image: imageString, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            if status == "success" {
                ACAlert.show(message: "Successfully Add Parent")
                UserDefaults.standard.removeObject(forKey: "AddParentProfileImg")
            } else {
                ACAlert.show(message: "Failed Add Parent")
            }
            SVProgressHUD.dismiss()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    
    @objc func editParent(){
        guard let obj = ACData.CLASSROOMSTUDENTDETAILDATA  else { return }
        guard let yearId = ACData.LOGINDATA.dashboardSchoolMenu[0].year_id else {
            return
        }
        if let dataImage = UserDefaults.standard.string(forKey: "AddParentProfileImg") {
            self.imageString = "data:image/png;base64,\(dataImage)"
        }
        let fullPhone = "\(tempCountryCode)\(phoneNumbTextField.text!)"
        ACRequest.POST_CLASSROOM_STUDENT_ADD_PARENT(user_id: ACData.LOGINDATA.userID, school_id: schoolId!, year_id: yearId, child_id: obj.child_id, parent_name: parentNameTextField.text!, parent_phone: fullPhone, gender: maleFemale, parent_type: "1", parent_address: addressTextField.text! , parent_email: emailTextField.text!, parent_id: selectedParentId, parent_image: imageString, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            if status == "success" {
                ACAlert.show(message: "Successfully Add Parent")
                UserDefaults.standard.removeObject(forKey: "AddParentProfileImg")
            } else {
                ACAlert.show(message: "Failed Add Parent")
            }
            SVProgressHUD.dismiss()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func profileImageTap(){
        if parentImage.image == UIImage(named: "plus"){
            parentImage.layer.cornerRadius = 0
            deleteImgBtn.isHidden = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            parentImage.isUserInteractionEnabled = true
            parentImage.addGestureRecognizer(tapGestureRecognizer)
        } else {
            parentImage.layer.cornerRadius = parentImage.frame.size.width/2
            deleteImgBtn.isHidden = false
            parentImage.isUserInteractionEnabled = false
            deleteImgBtn.addTarget(self, action: #selector(deleteImg), for: .touchUpInside)
        }
    }
    @objc func deleteImg(){
        parentImage.image = UIImage(named: "plus")
        parentImage.layer.cornerRadius = 0
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        parentImage.isUserInteractionEnabled = true
        parentImage.addGestureRecognizer(tapGestureRecognizer)
        deleteImgBtn.isHidden = true
        UserDefaults.standard.removeObject(forKey: "AddParentProfileImg")
        imageString = ""
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        showAttachment()
    }
    var isAddParent:Bool?
    var selectedDate = ""
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        configNavigation()
        populateData()
        terminateStudentBtn.addTarget(self, action: #selector(showTerminatePopUp), for: .touchUpInside)
        datePicker.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        cancelBtn.addTarget(self, action: #selector(closeTerminatePopUp), for: .touchUpInside)
        grayAreaBtn.addTarget(self, action: #selector(closeTerminatePopUp), for: .touchUpInside)
        yesBtn.addTarget(self, action: #selector(terminateStudent), for: .touchUpInside)
        editStudentBtn.addTarget(self, action: #selector(toEditStudent), for: .touchUpInside)
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "View Student", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "View Student", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable(){
        tableView.register(UINib(nibName: "StudentDetailCell", bundle: nil), forCellReuseIdentifier: "studentDetailCell")
        tableView.register(UINib(nibName: "StudentParentCell", bundle: nil), forCellReuseIdentifier: "studentParentCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    func populateData(){
        guard let obj = ACData.CLASSROOMSTUDENTDETAILDATA else { return }
        profileImage.sd_setImage(
            with: URL(string: (obj.child_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        childName.text = obj.child_name
        childNIS.text = obj.nisn
    }
    @objc func showDatePicker() {
        ActionSheetDatePicker.show(
            withTitle: "- Select Date -",
            datePickerMode: .date,
            selectedDate: Date(),
            doneBlock: { picker, selectedDate, origin in
                let dateFormatter = DateFormatter()
                let locale = Locale(identifier: "id")
                dateFormatter.dateFormat = "dd/MM/yyyy"
                dateFormatter.locale = locale
                let selectedDate = dateFormatter.string(from: selectedDate as! Date)
                self.datePicker.setTitle(selectedDate, for: .normal)
                self.selectedDate = selectedDate
        }, cancel: nil, origin: view)
    }
    @objc func terminateStudent(){
        guard let yearId = ACData.LOGINDATA.dashboardSchoolMenu[0].year_id else {
            return
        }
        guard let obj = ACData.CLASSROOMSTUDENTDETAILDATA else { return }
        ACRequest.POST_TERMINATE_CLASSROOM_STUDENT(userId: ACData.LOGINDATA.userID, schoolId: schoolId!, yearId: yearId, childId: obj.child_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (success) in
            if success == "success" {
                ACAlert.show(message: "Successfully Terminate Student")
            } else {
                ACAlert.show(message: "Failed Terminate Student")
            }
            SVProgressHUD.dismiss()
        }) { (failed) in
            SVProgressHUD.dismiss()
        }
    }
    @objc func showGenderPicker() {
        ActionSheetStringPicker.show(
            withTitle: "Gender",
            rows: genderList,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.genderPicker.setTitle(value, for: .normal)
                self.maleFemale = value
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func showRelationPicker() {
        ActionSheetStringPicker.show(
            withTitle: "Relation",
            rows: relationList,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.relationPicker.setTitle(value, for: .normal)
                self.pickedRelation = value
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func toEditStudent(){
        guard let yearId = ACData.LOGINDATA.dashboardSchoolMenu[0].year_id else {
            return
        }
        guard let obj = ACData.CLASSROOMSTUDENTDETAILDATA else { return }
        ACRequest.POST_GET_EDIT_STUDENT_DETAIL(userId: ACData.LOGINDATA.userID, schoolId: schoolId!, yearId: yearId, childId: obj.child_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (studentData) in
            ACData.CLASSROOMGETEDITSTUDENTDATA = studentData
            SVProgressHUD.dismiss()
            let editStudentVC = EditStudentViewController()
            editStudentVC.schoolId = self.schoolId!
            editStudentVC.roleId = "\(obj.role_id)"
            editStudentVC.childId = obj.child_id
            self.navigationController?.pushViewController(editStudentVC, animated: true)
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
}
extension StudentDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + ACData.CLASSROOMSTUDENTDETAILDATA.parents.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 519
        } else {
            return 100
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = (tableView.dequeueReusableCell(withIdentifier: "studentDetailCell", for: indexPath) as? StudentDetailCell)!
            cell.studentObjc = ACData.CLASSROOMSTUDENTDETAILDATA
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "studentParentCell", for: indexPath) as? StudentParentCell)!
            cell.parentObjc = ACData.CLASSROOMSTUDENTDETAILDATA.parents[indexPath.row-1]
            cell.delegate = self
            return cell
        }
    }
}
extension StudentDetailViewController{
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
extension StudentDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        let newImage = selectedImage.resizeImage(30.0, opaque: false)
        let imageData = newImage.pngData()!
        let imageStr = imageData.base64EncodedString()
        UserDefaults.standard.set(imageStr, forKey: "AddParentProfileImg")
        UserDefaults.standard.synchronize()
        picker.dismiss(animated: true) {
            self.parentImage.image = selectedImage
            self.deleteImgBtn.isHidden = false
            self.parentImage.isUserInteractionEnabled = false
            self.deleteImgBtn.addTarget(self, action: #selector(self.deleteImg), for: .touchUpInside)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
}
extension StudentDetailViewController:StudentDetailCellDelegate, StudentParentCellDelegate{
    func toPopup(parentName: String, parentImage: String, parentRelation: String, parentPhone: String, parentAddress: String, parentEmail: String, parentGender: String, parentId : String) {
        showEditStudentPopUp(parentName: parentName, parentImage: parentImage, parentRelation: parentRelation, parentPhone: parentPhone, parentAddress: parentAddress, parentEmail: parentEmail, parentGender: parentGender)
        selectedParentId = parentId
        maleFemale = parentGender
        addParentBtn.addTarget(self, action: #selector(editParent), for: .touchUpInside)
    }
    
    func toAddParentPopUp() {
        showAddStudentPopUp()
        addParentBtn.addTarget(self, action: #selector(addParent), for: .touchUpInside)
    }
}
extension StudentDetailViewController: FPNTextFieldDelegate {
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
    }
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        let codeNum = dialCode
        tempCountryCode = codeNum.replacingOccurrences(of: "+", with: "")
    }
}
