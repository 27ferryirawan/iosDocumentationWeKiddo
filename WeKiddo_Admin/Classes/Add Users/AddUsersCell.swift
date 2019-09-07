//
//  AddUsersCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 07/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import FlagPhoneNumber
import ActionSheetPicker_3_0
import SVProgressHUD

protocol AddUsersCellDelegate: class {
    func showImageAttachment()
}

class AddUsersCell: UITableViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var phoneCodeAreaTxt: FPNTextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var groupButton: UIButton!
    @IBOutlet weak var positionButton: UIButton!
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var addAvatarImageButton: UIButton!
    
    var userName = ""
    var userAddress = ""
    var userPhoneNumber = ""
    var userEmail = ""
    var userGender = ""
    var userPosition = ""
    var userGroup = ""
    var countryCode = ""
    var genderArray = ["Male", "Female"]
    var positionArray = [String]()
    var groupArray = [String]()
    var imageChoosen = ""
    
    weak var delegate: AddUsersCellDelegate?
    var detailObj: AddUserParamModel? {
        didSet {
            cellConfig()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        addAvatarImageButton.addTarget(self, action: #selector(openImageAttachment), for: .touchUpInside)
        genderButton.addTarget(self, action: #selector(showGenderPicker), for: .touchUpInside)
        positionButton.addTarget(self, action: #selector(showPositionPicker), for: .touchUpInside)
        groupButton.addTarget(self, action: #selector(showGroupPicker), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        
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
        guard let obj = detailObj else { return }
        positionArray.removeAll()
        groupArray.removeAll()
        for positionItem in obj.user_position_list {
            positionArray.append(positionItem.admin_pos_name)
        }
        for groupItem in obj.user_acl_list {
            groupArray.append(groupItem.desc_acl)
        }
//        avatarImage.image = imageChoosen
     }
    @objc func saveAction() {
        print("name: \(userName) \n\n address: \(userAddress) \n\n phone: \(countryCode+userPhoneNumber) \n\n email: \(userEmail) \n\n gender: \(userGender) \n\n position: \(userPosition) \n\n group: \(userGroup)")
        
        ACRequest.POST_SAVE_USER_NEW(userId: ACData.LOGINDATA.userID, adminID: "", name: userName, address: userAddress, phone: countryCode+userPhoneNumber, email: userEmail, gender: userGender, adminPosID: userPosition, groupACLId: userGroup, adminPhoto: imageChoosen, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (result) in
            ACAlert.show(message: result)
            SVProgressHUD.dismiss()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    @objc func openImageAttachment() {
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
                self.userGender = value
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
                guard let obj = self.detailObj else { return }
                self.userPosition = obj.user_position_list[indexes].admin_pos_id
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func showGroupPicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Type -",
            rows: groupArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.groupButton.setTitle(value, for: .normal)
                guard let obj = self.detailObj else { return }
                self.userGroup = obj.user_acl_list[indexes].group_acl_id
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
}

extension AddUsersCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameText {
            userName = textField.text!
        } else if textField == addressText {
            userAddress = textField.text!
        } else if textField == phoneText {
            userPhoneNumber = textField.text!
        } else if textField == emailText {
            userEmail = textField.text!
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameText {
            userName = textField.text!
        } else if textField == addressText {
            userAddress = textField.text!
        } else if textField == phoneText {
            userPhoneNumber = textField.text!
        } else if textField == emailText {
            userEmail = textField.text!
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameText {
            userName = textField.text!
        } else if textField == addressText {
            userAddress = textField.text!
        } else if textField == phoneText {
            userPhoneNumber = textField.text!
        } else if textField == emailText {
            userEmail = textField.text!
        }
        textField.resignFirstResponder()
        return true
    }
}

extension AddUsersCell: FPNTextFieldDelegate {
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
    }
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        let codeNum = dialCode
        countryCode = codeNum.replacingOccurrences(of: "+", with: "")
//        self.delegate?.phoneCountryCodeFilledWith(value: countryCode)
    }
}
