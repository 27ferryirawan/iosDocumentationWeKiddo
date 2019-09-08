//
//  EditStudentCell.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 04/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import FlagPhoneNumber
import ActionSheetPicker_3_0

protocol EditStudentCellDelegate : class{
    func saveData(child_name: String, child_nis: String, child_address: String, child_phone: String, child_email: String, child_gender: String, child_bod: String, school_class_id: String, child_image: String)
    func showAttachment()
}
class EditStudentCell: UITableViewCell {

    weak var delegate : EditStudentCellDelegate?
    var classList = [String]()
    var genderList = ["Male","Female"]
    var maleFemale = ""
    var classId = ""
    var joinDate = ""
    var bday = ""
    var tempCountryCode = ""
    var imageString = ""
    @IBOutlet weak var schoolPickerBtn: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var NISTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var deleteImgBtn: UIButton!
    @IBOutlet weak var countryCode: FPNTextField!{
        didSet{
            countryCode.hasPhoneNumberExample = false
            countryCode.placeholder = ""
        }
    }
    @IBOutlet weak var phoneNumbTextFiled: UITextField!
    @IBOutlet weak var addressTextFiled: UITextField!
    @IBOutlet weak var joinDatePickerBtn: UIButton!
    @IBOutlet weak var birthDatePickerBtn: UIButton!
    @IBOutlet weak var genderPickerBtn: UIButton!
    @IBOutlet weak var joinclassPickerBtn: UIButton!
    @IBOutlet weak var changeClassRoomPickerBtn: UIButton!
    @IBOutlet weak var emailTextField: TextFieldSpace!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var changeClassRoomView: UIView!{
        didSet{
            changeClassRoomView.layer.borderWidth = 1
            changeClassRoomView.layer.borderColor = UIColor.red.cgColor
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        saveBtn.addTarget(self, action: #selector(saveStudentData), for: .touchUpInside)
//        let editStudentVC = EditStudentViewController()
//        countryCode.parentViewController = editStudentVC
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    var studentObjc : GetEditStudentDetailModel?{
        didSet{
            cellDataSet()
        }
    }
    func cellDataSet(){
        guard let obj = studentObjc else { return }
        schoolPickerBtn.setTitle(obj.school_name, for: .normal)
        nameTextField.text = obj.child_name
        NISTextField.text = obj.child_nis
        if obj.child_image .isEmpty || obj.child_image == "" || profileImage.image == UIImage(named: ""){
            deleteImgBtn.isHidden = true
            profileImage.image = UIImage(named: "plus")
            profileImage.layer.cornerRadius = 0
            profileImageTap()
        } else if profileImage.image != UIImage(named: "plus") && profileImage.image != UIImage(named: ""){
            profileImage.layer.cornerRadius = profileImage.frame.size.width/2
            deleteBtnActive()
            deleteImgBtn.isHidden = false
            self.profileImage.sd_setImage(
                with: URL(string: (obj.child_image)),
                placeholderImage: UIImage(named: "WeKiddoLogo"),
                options: .refreshCached
            )
        }
        addressTextFiled.text = obj.child_address
        if "+\(obj.child_phone.prefix(2))" == "+62"{
            countryCode.setFlag(for: FPNCountryCode.ID)
            tempCountryCode = "62"
        }
        countryCode.delegate = self
        phoneNumbTextFiled.text = "\(obj.child_phone.suffix(obj.child_phone.count-2))"
        joinDatePickerBtn.setTitle(obj.coming_date, for: .normal)
        joinDate = obj.coming_date
        joinDatePickerBtn.addTarget(self, action: #selector(showJoinDatePicker), for: .touchUpInside)
        birthDatePickerBtn.setTitle(toDateString(time: obj.child_bod), for: .normal)
        birthDatePickerBtn.addTarget(self, action: #selector(showBirthDatePicker), for: .touchUpInside)
        bday = toDateString(time: obj.child_bod)
        genderPickerBtn.setTitle(obj.child_gender, for: .normal)
        genderPickerBtn.addTarget(self, action: #selector(showGenderPicker), for: .touchUpInside)
        maleFemale = obj.child_gender
        emailTextField.text = obj.child_email
//        joinclassPickerBtn.setTitle(obj., for: )
        changeClassRoomPickerBtn.setTitle(obj.school_class, for: .normal)
        changeClassRoomPickerBtn.addTarget(self, action: #selector(showClassPicker), for: .touchUpInside)
    }
    func profileImageTap(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.delegate?.showAttachment()
    }
    func deleteBtnActive(){
        deleteImgBtn.isHidden = false
        profileImage.isUserInteractionEnabled = false
        deleteImgBtn.addTarget(self, action: #selector(deleteImage), for: .touchUpInside)
    }
    @objc func deleteImage(){
        profileImage.image = UIImage(named: "plus")
        deleteImgBtn.isHidden = true
        profileImage.layer.cornerRadius = 0
        profileImage.isUserInteractionEnabled = true
        UserDefaults.standard.removeObject(forKey: "EditStudentProfileImage")
        imageString = ""
    }
    @objc func saveStudentData(){
        if let dataImage = UserDefaults.standard.string(forKey: "EditStudentProfileImage") {
//            self.imageString = dataImage
            self.imageString = "data:image/png;base64,\(dataImage)"
        }
        let fullPhone = "\(tempCountryCode)\(phoneNumbTextFiled.text!)"
        print(fullPhone)
        self.delegate?.saveData(child_name: nameTextField.text!, child_nis: NISTextField.text!, child_address: addressTextFiled.text!, child_phone: fullPhone, child_email: emailTextField.text! , child_gender: maleFemale, child_bod: bday, school_class_id: classId, child_image: imageString)
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
    @objc func showClassPicker() {
        classList.removeAll()
        for a in ACData.CLASSROOMGETEDITSTUDENTDATA.edit_child_class{
            classList.append(a.school_class)
        }
        ActionSheetStringPicker.show(
            withTitle: "- Select Class -",
            rows: classList,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.changeClassRoomPickerBtn.setTitle(value, for: .normal)
                self.classId = ACData.CLASSROOMGETEDITSTUDENTDATA.edit_child_class[indexes].school_class_id
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
}
extension EditStudentCell {
    func toDateString(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        
        // then convert date to string again
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "yyyy-MM-dd"
        let stringDate = dateFormatterResult.string(from: date)
        
        return stringDate
    }
}
extension EditStudentCell: FPNTextFieldDelegate {
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
    }
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        let codeNum = dialCode
        tempCountryCode = codeNum.replacingOccurrences(of: "+", with: "")
    }
}
