//
//  AddStudentCell.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 06/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import FlagPhoneNumber
import ActionSheetPicker_3_0

protocol AddStudentCellDelegate : class{
    func saveData(child_name: String, child_nis: String, child_address: String, child_phone: String, child_email: String, child_gender: String, child_bod: String, child_image: String, schoolId : String)
    func showAttachment()
}

class AddStudentCell: UITableViewCell {
    
    var selectedSchoold = ""
    var schools: [String] = []
    var joinDate = ""
    var selectedDate = ""
    var imageString = ""
    var tempCountryCode = ""
    var classList = [String]()
    var schoolList = [String]()
    var genderList = ["Male","Female"]
    var maleFemale = ""
    var classId = ""
    var bday = ""
    weak var delegate: AddStudentCellDelegate?
    @IBOutlet weak var schoolPickerBtn: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var NISTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!{
        didSet{
            profileImage.image = UIImage(named: "plus")
            profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        }
    }
    @IBOutlet weak var deleteImgBtn: UIButton!
    @IBOutlet weak var countryCode: FPNTextField!{
        didSet{
            countryCode.hasPhoneNumberExample = false
            countryCode.placeholder = ""
            countryCode.delegate = self
        }
    }
    @IBOutlet weak var phoneNumbTextFiled: UITextField!
    @IBOutlet weak var addressTextFiled: UITextField!
    @IBOutlet weak var joinDatePickerBtn: UIButton!
    @IBOutlet weak var birthDatePickerBtn: UIButton!
    @IBOutlet weak var genderPickerBtn: UIButton!
    @IBOutlet weak var emailTextField: TextFieldSpace!
    @IBOutlet weak var saveBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageTap()
        joinDatePickerBtn.addTarget(self, action: #selector(showJoinDatePicker), for: .touchUpInside)
        birthDatePickerBtn.addTarget(self, action: #selector(showBirthDatePicker), for: .touchUpInside)
        genderPickerBtn.addTarget(self, action: #selector(showGenderPicker), for: .touchUpInside)
//        schoolPickerBtn.addTarget(self, action: #selector(showSchoolPicker), for: .touchUpInside)
        saveBtn.addTarget(self, action: #selector(saveStudentData), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func showJoinDatePicker() {
        ActionSheetDatePicker.show(
            withTitle: "- Select Date -",
            datePickerMode: .date,
            selectedDate: Date(),
            doneBlock: { picker, selectedDate, origin in
                let dateFormatter = DateFormatter()
                let locale = Locale(identifier: "id")
                dateFormatter.dateFormat = "yyyy-MM-dd"
                dateFormatter.locale = locale
                let selectedDate = dateFormatter.string(from: selectedDate as! Date)
                self.joinDatePickerBtn.setTitle(selectedDate, for: .normal)
                self.joinDate = selectedDate
        }, cancel: nil, origin: self)
    }
    func profileImageTap(){
        if profileImage.image == UIImage(named: "plus"){
            profileImage.layer.cornerRadius = 0
            deleteImgBtn.isHidden = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            profileImage.isUserInteractionEnabled = true
            profileImage.addGestureRecognizer(tapGestureRecognizer)
        } else {
            profileImage.layer.cornerRadius = profileImage.frame.size.width/2
            deleteImgBtn.isHidden = false
            profileImage.isUserInteractionEnabled = false
            deleteImgBtn.addTarget(self, action: #selector(deleteImg), for: .touchUpInside)
        }
    }
    @objc func deleteImg(){
        profileImage.image = UIImage(named: "plus")
        profileImage.layer.cornerRadius = 0
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapGestureRecognizer)
        deleteImgBtn.isHidden = true
        UserDefaults.standard.removeObject(forKey: "AddStudentProfileImg")
        imageString = ""
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.delegate?.showAttachment()
    }
    @objc func showSchoolPicker() {
        schools.removeAll()
        for value in ACData.LOGINDATA.dashboardSchoolMenu {
            schools.append(value.school_name!)
        }
        ActionSheetStringPicker.show(
            withTitle: "Select School",
            rows: schools,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let schoolID = ACData.LOGINDATA.dashboardSchoolMenu[indexes].school_id else {
                    return
                }
                self.schoolPickerBtn.setTitle(self.schools[indexes], for: .normal)
                self.selectedSchoold = schoolID
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func showGenderPicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Gender -",
            rows: genderList,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.genderPickerBtn.setTitle(value, for: .normal)
                self.maleFemale = value
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func showBirthDatePicker() {
        ActionSheetDatePicker.show(
            withTitle: "- Select Date -",
            datePickerMode: .date,
            selectedDate: Date(),
            doneBlock: { picker, selectedDate, origin in
                let dateFormatter = DateFormatter()
                let locale = Locale(identifier: "id")
                dateFormatter.dateFormat = "yyyy-MM-dd"
                dateFormatter.locale = locale
                let selectedDate = dateFormatter.string(from: selectedDate as! Date)
                self.birthDatePickerBtn.setTitle(selectedDate, for: .normal)
                self.bday = selectedDate
        }, cancel: nil, origin: self)
    }
    
    @objc func saveStudentData(){
        if let dataImage = UserDefaults.standard.string(forKey: "AddStudentProfileImg") {
            //            self.imageString = dataImage
            self.imageString = "data:image/png;base64,\(dataImage)"
        }
        let fullPhone = "\(tempCountryCode)\(phoneNumbTextFiled.text!)"
        print(fullPhone)
        self.delegate?.saveData(child_name: nameTextField.text!, child_nis: NISTextField.text!, child_address: addressTextFiled.text!, child_phone: fullPhone, child_email: emailTextField.text! , child_gender: maleFemale, child_bod: bday, child_image: imageString, schoolId : selectedSchoold)
    }
}
extension AddStudentCell: FPNTextFieldDelegate {
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
    }
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        let codeNum = dialCode
        tempCountryCode = codeNum.replacingOccurrences(of: "+", with: "")
    }
}
