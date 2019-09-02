//
//  ForgotViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 13/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class ForgotViewController: UIViewController {

    let thePicker = UIPickerView()
    let myPickerData = ["+62", "+444", "+24", "+99", "+65", "+90"]
    var isFromEdit = Bool()
    
    @IBOutlet weak var submitBtn: UIButton! {
        didSet {
            submitBtn.layer.cornerRadius = 5
            submitBtn.clipsToBounds = true
        }
    }
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var txtPhoneCode: UITextField! {
        didSet {
            txtPhoneCode.inputView = thePicker
        }
    }
    @IBOutlet weak var txtPhoneNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        config()
    }
    func configNavigation() {
        self.navigationController?.isNavigationBarHidden = false
        detectAdaptiveClass()
        if isFromEdit {
            backStyleNavigationController(pageTitle: "Change Password", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        } else {
            backStyleNavigationController(pageTitle: "Forget Password", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func config() {
        thePicker.delegate = self
        createToolbar(sender: txtPhoneCode!)
    }
    
    @IBAction func submitProcess(_ sender: UIButton) {
        let phone = "\(txtPhoneCode.text!)\(txtPhoneNumber.text!)"
        let newCode = phone.replacingOccurrences(of: "+", with: "")
        ACRequest.POST_FORGOT_CHECK_PHONE(
            phone: newCode,
            tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            if status {
                PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { (verificationID, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    let defaults = UserDefaults.standard
                    defaults.set(verificationID, forKey: "authVID")
                    let otpVC = OTPViewController()
                    otpVC.phone = phone
                    self.navigationController?.pushViewController(otpVC, animated: true)
                }
            } else {
                let alert = UIAlertController(title: "Info", message: "Phone is not registered.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }) { (message) in
            let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
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
        view.endEditing(true)
    }
}

extension ForgotViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        txtPhoneCode.text = myPickerData[row]
    }
}

extension ForgotViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text!)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
