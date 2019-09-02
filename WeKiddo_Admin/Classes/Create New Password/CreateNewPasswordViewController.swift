//
//  CreateNewPasswordViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 13/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class CreateNewPasswordViewController: UIViewController {

    @IBOutlet weak var newPassTxt: UITextField!
    @IBOutlet weak var confirmNewPassTxt: UITextField!
    var phoneNumber = ""
    @IBOutlet weak var btnSubmit: UIButton! {
        didSet {
            btnSubmit.layer.cornerRadius = 5
            btnSubmit.clipsToBounds = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
    }
    
    func configNavigation() {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func submitClicked(_ sender: UIButton) {
        guard let newPass = newPassTxt.text, let confirmPass = confirmNewPassTxt.text else {
            return
        }
        if newPass == confirmPass {
            ACRequest.POST_FORGOT_SET_NEW(
                userID: ACData.LOGINDATA.userID,
                newPass: newPass,
                phone: phoneNumber,
                tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
                if status {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }) { (message) in
                let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Message", message: "Confirmation password must be same with password.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
extension CreateNewPasswordViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == newPassTxt {
            confirmNewPassTxt.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
