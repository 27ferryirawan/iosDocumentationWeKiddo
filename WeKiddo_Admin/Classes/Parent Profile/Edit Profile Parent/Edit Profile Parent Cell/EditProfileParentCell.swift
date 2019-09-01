//
//  EditProfileParentCell.swift
//  WeKiddo
//
//  Created by zein rezky chandra on 19/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
import ActionSheetPicker_3_0

protocol EditProfileParentDelegate: class {
    func dismisView()
    func showImagePicker()
    func displayAddSubjectView()
    func addressFieldFilled(withAddress: String)
    func phoneFilled(withString: String)
    func emailFilled(withEmail: String)
    func positionFilled(withID: String)
    func genderFilled(withGender: String)
    func dobFilled(withDob: String)
}

class EditProfileParentCell: UITableViewCell {
    
    let thePicker = UIPickerView()
    let myPickerData = ["+62", "+444", "+24", "+99", "+65", "+90"]
    var genderArray = ["Female", "Male"]
    var positionArray = ["Teacher", "Principal", "Homeroom Teacher", "Administration", "Others"]

    @IBOutlet weak var changeAvatarButton: UIButton!
    var base64String = ""
    var countryCode = ""
    var telephone = ""
    @IBOutlet weak var profileImage: UIImageView!{
        didSet{
            profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        }
    }
    @IBOutlet weak var nameLbl: UITextField!
    @IBOutlet weak var nipLabel: TextFieldSpace!
    @IBOutlet weak var addressLabel: TextFieldSpace!
    @IBOutlet weak var phoneLabel: UITextField!
    @IBOutlet weak var countryLabel: UITextField! {
        didSet {
            countryLabel.inputView = thePicker
        }
    }
    @IBOutlet weak var emailLabel: TextFieldSpace!
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var positionButton: UIButton!
    @IBOutlet weak var dobButton: UIButton!
    
    @IBOutlet weak var changePasswordBtn: UIButton! {
        didSet {
            changePasswordBtn.layer.cornerRadius = 5
            changePasswordBtn.clipsToBounds = true
            changePasswordBtn.setTitle("Discard", for: .normal)
            changePasswordBtn.backgroundColor = ACColor.MAIN
        }
    }
    @IBOutlet weak var changeProfileBtn: UIButton! {
        didSet {
            changeProfileBtn.layer.cornerRadius = 5
            changeProfileBtn.clipsToBounds = true
            changeProfileBtn.setTitle("Save", for: .normal)
            changeProfileBtn.backgroundColor = ACColor.MAIN
        }
    }
    weak var delegate: EditProfileParentDelegate?
    var detailObj: AdminProfileModel? {
        didSet {
            cellDataSet()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        changeAvatarButton.addTarget(self, action: #selector(changeAvatar), for: .touchUpInside)
        positionButton.addTarget(self, action: #selector(showPositionPicker), for: .touchUpInside)
        genderButton.addTarget(self, action: #selector(showGenderPicker), for: .touchUpInside)
        dobButton.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        thePicker.delegate = self
        createToolbar(sender: countryLabel!)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func createToolbar(sender: UITextField){
        let datePickerToolbar = UIToolbar()
        datePickerToolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        doneButton.tag = sender.tag
        datePickerToolbar.setItems([doneButton], animated: false)
        datePickerToolbar.isUserInteractionEnabled = true
        sender.inputAccessoryView = datePickerToolbar
    }
    @objc func dismissKeyboard(on: UIButton){
        self.endEditing(true)
    }
    @objc func showPositionPicker() {
        ActionSheetStringPicker.show(
            withTitle: "Select Gender",
            rows: positionArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.positionButton.setTitle(value, for: .normal)
                self.delegate?.positionFilled(withID: "\(indexes+1)")
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func showGenderPicker() {
        ActionSheetStringPicker.show(
            withTitle: "Select Gender",
            rows: genderArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.genderButton.setTitle(value, for: .normal)
                self.delegate?.genderFilled(withGender: value)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func showDatePicker() {
        ActionSheetDatePicker.show(
            withTitle: "- Select Date -",
            datePickerMode: .date,
            selectedDate: Date(),
            doneBlock: { picker, selectedDate, origin in
                let dateFormatter = DateFormatter()
                let dateFormatter2 = DateFormatter()
                let locale = Locale(identifier: "id")
                dateFormatter.dateFormat = "dd/MM/yyyy"
                dateFormatter2.dateFormat = "yyyy-MM-dd"
                dateFormatter.locale = locale
                dateFormatter2.locale = locale
                let selectedDates = dateFormatter.string(from: selectedDate as! Date)
                let choosenDate = dateFormatter2.string(from: selectedDate as! Date)
                self.dobButton.setTitle(selectedDates, for: .normal)
                self.delegate?.dobFilled(withDob: selectedDates)
//                self.delegate?.dateSelected(atIndex: self.indexArray, value: choosenDate)
        }, cancel: nil, origin: self)
    }
    @objc func addSubjectAction() {
        self.delegate?.displayAddSubjectView()
    }
    @objc func changeAvatar() {
        self.delegate?.showImagePicker()
    }
    func cellDataSet() {
        guard let obj = detailObj else { return }
        if let selectedImage = UserDefaults.standard.string(forKey: "SelectedImageFile") {
            if selectedImage != "" {
                guard let dataDecoded = NSData(base64Encoded: selectedImage, options: NSData.Base64DecodingOptions(rawValue: 0)) else { return }
                let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
                print(decodedimage)
                self.profileImage.image = decodedimage
            } else {
                self.profileImage.sd_setImage(
                    with: URL(string: (obj.admin_photo)),
                    placeholderImage: UIImage(named: "WeKiddoLogo"),
                    options: .refreshCached
                )
            }
        } else {
            self.profileImage.sd_setImage(
                with: URL(string: (obj.admin_photo)),
                placeholderImage: UIImage(named: "WeKiddoLogo"),
                options: .refreshCached
            )
        }
        //        self.titleLabel.text = title
        self.nameLbl.text = obj.name
        self.nipLabel.text = ""
        self.addressLabel.text = obj.address
        self.emailLabel.text = obj.email
        self.positionButton.setTitle(obj.admin_pos_name, for: .normal)
        self.genderButton.setTitle(obj.gender, for: .normal)
        self.dobButton.setTitle(obj.admin_dob, for: .normal)
        countryCode = String(obj.phone.prefix(2))
        self.countryLabel.text = String(obj.phone.prefix(2))
        self.phoneLabel.text = String(obj.phone.dropFirst(2))
        
        positionArray.removeAll()
        positionArray = obj.posList.map({$0.admin_pos_name})
    }
    @IBAction func changeProfile(_ sender: UIButton) {
        if let chosedImage = UserDefaults.standard.string(forKey: "ParentSelectedImageFile") {
            base64String = chosedImage
        }
        guard let obj = detailObj else {
            return
        }
        if obj.phone != phoneLabel.text! {
            print(phoneLabel.text!)
//            self.delegate?.requestOTPVerification(parentID: ACData.USER.parent_id, parentName: nameLbl.text!, parentPhone: phoneLbl.text!, parentEmail: emailLbl.text!, parentAddress: addressLbl.text!, parentOccupation: occupationLbl.text!, parentCompany: companyLbl.text!, parentPosition: positionLbl.text!, parentImage: base64String)
        } else {
            updateProfileAutomatically()
        }
    }
    func updateProfileAutomatically() {
        if let chosedImage = UserDefaults.standard.string(forKey: "ParentSelectedImageFile") {
            base64String = chosedImage
        }
//        ACRequest.POST_UPDATE_PARENT_PROFILE(parentID: ACData.USER.parent_id, parentName: nameLbl.text!, parentPhone: phoneLbl.text!, parentEmail: emailLbl.text!, parentAddress: addressLbl.text!, parentOccupation: occupationLbl.text!, parentCompany: companyLbl.text!, parentPosition: positionLbl.text!, parentImage: base64String, successCompletion: { (message) in
//            SVProgressHUD.dismiss()
//            self.delegate?.dismisView()
//            UserDefaults.standard.removeObject(forKey: "ParentSelectedImageFile")
//            UserDefaults.standard.synchronize()
//        }) { (message) in
//            SVProgressHUD.dismiss()
//            ACAlert.show(message: message)
//        }
    }
}

extension EditProfileParentCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerData.count
    }
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerData[row]
    }
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryLabel.text = myPickerData[row]
        countryCode = myPickerData[row]
    }
}

extension EditProfileParentCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameLbl {
            nipLabel.becomeFirstResponder()
        } else if textField == nipLabel {
            addressLabel.becomeFirstResponder()
        } else if textField == addressLabel {
            self.delegate?.addressFieldFilled(withAddress: textField.text!)
            phoneLabel.becomeFirstResponder()
        } else if textField == phoneLabel {
            telephone = "\(countryCode)\(textField.text!)"
            let newPhone = telephone.replacingOccurrences(of: "+", with: "")
            self.delegate?.phoneFilled(withString: newPhone)
            emailLabel.becomeFirstResponder()
        } else {
            self.delegate?.emailFilled(withEmail: textField.text!)
            textField.resignFirstResponder()
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text!)
        if textField == nameLbl {
            nipLabel.becomeFirstResponder()
        } else if textField == nipLabel {
            addressLabel.becomeFirstResponder()
        } else if textField == addressLabel {
            self.delegate?.addressFieldFilled(withAddress: textField.text!)
            phoneLabel.becomeFirstResponder()
        } else if textField == phoneLabel {
            telephone = "\(countryCode)\(textField.text!)"
            let newPhone = telephone.replacingOccurrences(of: "+", with: "")
            self.delegate?.phoneFilled(withString: newPhone)
            emailLabel.becomeFirstResponder()
        } else {
            self.delegate?.emailFilled(withEmail: textField.text!)
            textField.resignFirstResponder()
        }

    }
}
