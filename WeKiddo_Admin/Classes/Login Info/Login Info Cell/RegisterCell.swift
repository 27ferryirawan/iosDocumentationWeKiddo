//
//  RegisterCell.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 29/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class RegisterCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var classTxt: UITextField!
    @IBOutlet weak var schoolNameTxt: UITextField!
    @IBOutlet weak var childNameTxt: UITextField!
    @IBOutlet weak var phoneNumberTxt: UITextField!
    @IBOutlet weak var phoneCodeTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        registerButton.addTarget(self, action: #selector(registAction), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTxt {
            phoneCodeTxt.becomeFirstResponder()
        } else if textField == phoneCodeTxt {
            phoneNumberTxt.becomeFirstResponder()
        } else if textField == phoneNumberTxt {
            childNameTxt.becomeFirstResponder()
        } else if textField == childNameTxt {
            schoolNameTxt.becomeFirstResponder()
        } else if textField == schoolNameTxt {
            classTxt.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    @objc func registAction() {
        guard let parentName = nameTxt.text, let phoneCode = phoneCodeTxt.text, let phoneNum = phoneNumberTxt.text, let childName = childNameTxt.text, let schoolName = schoolNameTxt.text, let schoolClass = classTxt.text else {
            return
        }
        ACRequest.POST_REGIST_SCHOOL(parentName: parentName, parentPhone: "\(phoneCode)\(phoneNum)", childName: childName, schoolName: schoolName, schoolClass: schoolClass, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: status)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}
