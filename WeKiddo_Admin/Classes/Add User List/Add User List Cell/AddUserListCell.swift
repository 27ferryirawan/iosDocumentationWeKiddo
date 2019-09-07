//
//  AddUserListCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 06/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import FlagPhoneNumber

protocol AddUserListCellDelegate: class {
    func showImageAttachment()
    func showAddNewView()
    func schoolSelectedWith(value: String, yearID: String, withTeacherID: String)
    func nameFilledWith(value: String)
    func nipFilledWith(value: String)
    func addressFilledWith(value: String)
    func phoneCountryCodeFilledWith(value: String)
    func phoneNumberFilledWith(value: String)
    func emailFilledWith(value: String)
    func genderSelectedWith(value: String)
    func positionSelectedWith(value: String)
    func classSelectedWith(value: String)
}

class AddUserListCell: UITableViewCell {

    @IBOutlet weak var addNewClassButton: UIButton!
    @IBOutlet weak var classButton: UIButton!
    @IBOutlet weak var positionButton: UIButton!
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var imageCollection: UICollectionView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var nipText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var selectSchoolButton: UIButton!
    var schoolArray = [String]()
    var genderArray = ["Male", "Female"]
    var positionArray = [String]()
    var classArray = [String]()
    var imagePhoto = UIImage()
    @IBOutlet weak var phoneCodeAreaTxt: FPNTextField!
    var countryCode = ""
    var isSchoolSelected = false
    weak var delegate: AddUserListCellDelegate?
    var obj: AddUserAddParamModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        selectSchoolButton.addTarget(self, action: #selector(showSchoolPicker), for: .touchUpInside)
        addPhotoButton.addTarget(self, action: #selector(showImagePicker), for: .touchUpInside)
        genderButton.addTarget(self, action: #selector(showGenderPicker), for: .touchUpInside)
        positionButton.addTarget(self, action: #selector(showPositionPicker), for: .touchUpInside)
        classButton.addTarget(self, action: #selector(showClassPicker), for: .touchUpInside)
        addNewClassButton.addTarget(self, action: #selector(addNewAction), for: .touchUpInside)
        imageCollection.register(UINib(nibName: "AddUserProfileImageCell", bundle: nil), forCellWithReuseIdentifier: "addUserProfileImageCellID")
//        phoneCodeAreaTxt.parentViewController = self
        phoneCodeAreaTxt.delegate = self
        phoneCodeAreaTxt.flagSize = CGSize(width: 35, height: 35)
        phoneCodeAreaTxt.flagButtonEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        phoneCodeAreaTxt.hasPhoneNumberExample = false
        phoneCodeAreaTxt.placeholder = ""
        let locale = Locale.current
        guard let currentCode = locale.regionCode else { return }
        phoneCodeAreaTxt.setFlag(for: FPNCountryCode.init(rawValue: currentCode)!)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = obj else { return }
        for schoolItem in ACData.USERSCHOOLLISTDATA {
            schoolArray.append(schoolItem.school_name)
        }
        for positionItem in obj.position_list {
            positionArray.append(positionItem.role_name)
        }
        for classItem in obj.class_list {
            classArray.append(classItem.school_class)
        }
    }
    @objc func showSchoolPicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Type -",
            rows: schoolArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.selectSchoolButton.setTitle(value, for: .normal)
                let schoolID = ACData.USERSCHOOLLISTDATA[indexes].school_id
                let yearID = ACData.USERSCHOOLLISTDATA[indexes].year_id
                self.delegate?.schoolSelectedWith(value: schoolID, yearID: yearID, withTeacherID: "")
                self.isSchoolSelected = true
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func showImagePicker() {
        self.delegate?.showImageAttachment()
    }
    @objc func showGenderPicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Type -",
            rows: genderArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.genderButton.setTitle(value, for: .normal)
                self.delegate?.genderSelectedWith(value: value)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func showPositionPicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Type -",
            rows: positionArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.positionButton.setTitle(value, for: .normal)
                guard let obj = self.obj else { return }
                let posID = obj.position_list[indexes].role_id
                self.delegate?.positionSelectedWith(value: "\(posID)")
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func showClassPicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Type -",
            rows: classArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.classButton.setTitle(value, for: .normal)
                guard let obj = self.obj else { return }
                let schoolClassID = obj.class_list[indexes].school_class_id
                self.delegate?.classSelectedWith(value: schoolClassID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func addNewAction() {
        if isSchoolSelected {
            self.delegate?.showAddNewView()
        } else {
            ACAlert.show(message: "Select school first")
        }
    }
}

extension AddUserListCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameText {
            self.delegate?.nameFilledWith(value: textField.text!)
        } else if textField == nipText {
            self.delegate?.nipFilledWith(value: textField.text!)
        } else if textField == addressText {
            self.delegate?.addressFilledWith(value: textField.text!)
        } else if textField == phoneText {
            self.delegate?.phoneNumberFilledWith(value: textField.text!)
        } else if textField == emailText {
            self.delegate?.emailFilledWith(value: textField.text!)
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameText {
            self.delegate?.nameFilledWith(value: textField.text!)
        } else if textField == nipText {
            self.delegate?.nipFilledWith(value: textField.text!)
        } else if textField == addressText {
            self.delegate?.addressFilledWith(value: textField.text!)
        } else if textField == phoneText {
            self.delegate?.phoneNumberFilledWith(value: textField.text!)
        } else if textField == emailText {
            self.delegate?.emailFilledWith(value: textField.text!)
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameText {
            self.delegate?.nameFilledWith(value: textField.text!)
        } else if textField == nipText {
            self.delegate?.nipFilledWith(value: textField.text!)
        } else if textField == addressText {
            self.delegate?.addressFilledWith(value: textField.text!)
        } else if textField == phoneText {
            self.delegate?.phoneNumberFilledWith(value: textField.text!)
        } else if textField == emailText {
            self.delegate?.emailFilledWith(value: textField.text!)
        }
        textField.resignFirstResponder()
        return true
    }
}

extension AddUserListCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "addUserProfileImageCellID", for: indexPath) as? AddUserProfileImageCell)!
        cell.userImage.image = self.imagePhoto
        return cell
    }
}

extension AddUserListCell: FPNTextFieldDelegate {
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
    }
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        let codeNum = dialCode
        countryCode = codeNum.replacingOccurrences(of: "+", with: "")
        self.delegate?.phoneCountryCodeFilledWith(value: countryCode)
    }
}
