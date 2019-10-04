//
//  ViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 11/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.

import UIKit
import SVProgressHUD
import FlagPhoneNumber

class ViewController: UIViewController {
    
    let thePicker = UIPickerView()
    let myPickerData = ["+62", "+444", "+24", "+99", "+65", "+90"]

    @IBOutlet weak var privacyPolicyBtn: UIButton!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var loginBtn: UIButton! {
        didSet{
            loginBtn.layer.cornerRadius = 5
            loginBtn.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var phoneCodeAreaTxt: FPNTextField!
    var countryCode = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigation()
//        checkVersion()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        privacyPolicyBtn.addTarget(self, action: #selector(goToPrivacyPolicyPage), for: .touchUpInside)
    }
    
    @objc func goToPrivacyPolicyPage() {
        let privacyPolicyVC = PrivacyPolicyViewController()
        self.navigationController?.pushViewController(privacyPolicyVC, animated: true)
    }
    
    func config() {
        thePicker.delegate = self
        phoneCodeAreaTxt.parentViewController = self
        phoneCodeAreaTxt.delegate = self
        phoneCodeAreaTxt.flagSize = CGSize(width: 35, height: 35)
        phoneCodeAreaTxt.flagButtonEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        phoneCodeAreaTxt.hasPhoneNumberExample = false
        phoneCodeAreaTxt.placeholder = ""
        let locale = Locale.current
        guard let currentCode = locale.regionCode else { return }
        phoneCodeAreaTxt.setFlag(for: FPNCountryCode.init(rawValue: currentCode)!)
//        createToolbar(sender: phoneAreaTxt!)
    }
    func checkVersion() {
        guard let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return
        }
        ACRequest.POST_CHECK_VERSION(userAgent: "iOS", agentType: "school_app", versionCode: appVersion, successCompletion: { (message) in
            SVProgressHUD.dismiss()
            let isUpdated = UserDefaults.standard.bool(forKey: "isStatusUpdate")
            let isForceUpdate = UserDefaults.standard.bool(forKey: "isForceUpdate")
            if isForceUpdate {
                self.openAppStore()
            } else {
                if isUpdated {
                    // do nothing, means installed apps already up to date
                } else {
                    let alert = UIAlertController(title: "Information", message: "New updated version of this app is available, please update to newest version on App Store.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Yes, I want.", style: UIAlertAction.Style.default, handler: { (action) in
                        // direct to app store
                        self.openAppStore()
                    }))
                    alert.addAction(UIAlertAction(title: "Remind me later.", style: UIAlertAction.Style.cancel, handler: { (action) in
                        // dismiss
                    }))
                }
            }
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func openAppStore() {
        //                https://apps.apple.com/us/app/wekiddo/id1467772748?ls=1
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id1467772748"),
            UIApplication.shared.canOpenURL(url)
        {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    private func getCustomTextFieldInputAccessoryView(with items: [UIBarButtonItem]) -> UIToolbar {
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.items = items
        toolbar.sizeToFit()
        return toolbar
    }
    @IBAction func submitLogin(_ sender: UIButton) {
        if countryCode == "" || phoneTxt.text! == "" || passwordTxt.text! == ""{
            let alert = UIAlertController(title: nil, message: "Masukkan no telepon dan sandi", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            guard let udidToken = UIDevice.current.identifierForVendor?.uuidString else { return }
            let phoneNumber = "\(countryCode)\(phoneTxt.text!)"
            var newPhoneNumber = phoneNumber.replacingOccurrences(of: "+", with: "")
            
            let index = newPhoneNumber.index(newPhoneNumber.startIndex, offsetBy: 2)
            print(newPhoneNumber[index])
            if newPhoneNumber.count > 2 && newPhoneNumber[index] == "0"{
                newPhoneNumber = newPhoneNumber.prefix(2) + "" + newPhoneNumber.dropFirst(3)
                print(newPhoneNumber)
//                newPhoneNumber = String(newPhoneNumber.dropFirst(2))
            } else {
                print("false")
            }
            ACRequest.POST_SIGNIN(tokenDevice: udidToken, phone: newPhoneNumber, password: passwordTxt.text!, userAgent: "ios", successCompletion: { (loginData) in
                ACData.LOGINDATA = loginData
                SVProgressHUD.dismiss()

                if ACData.LOGINDATA.dashboardSchoolMenu.count != 0 {
                    guard let schoolIndexZero = ACData.LOGINDATA.dashboardSchoolMenu[0].school_id, let yearIndexZero = ACData.LOGINDATA.dashboardSchoolMenu[0].year_id else {
                        return
                    }
                    ACRequest.POST_DASHBOARD(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: schoolIndexZero, yearID: yearIndexZero, tokenAccess:ACData.LOGINDATA.accessToken, successCompletion: { (dashboardData) in
                        ACData.DASHBOARDDATA = dashboardData
                        SVProgressHUD.dismiss()
                        self.passwordTxt.resignFirstResponder()
                        let appDelegate = UIApplication.shared.delegate as? AppDelegate
                        appDelegate?.goToHome()
                    }, failCompletion: { (message) in
                        SVProgressHUD.dismiss()
                    })
                }

            }) { (message) in
                SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    @IBAction func toForgetPage(_ sender: UIButton) {
        let forgetVC = ForgotViewController()
        forgetVC.isFromEdit = false
        self.navigationController?.pushViewController(forgetVC, animated: true)
    }
    func configNavigation() {
        self.navigationController?.isNavigationBarHidden = true
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

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerData.count
    }
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerData[row]
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text!)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == phoneTxt {
            passwordTxt.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension ViewController: FPNTextFieldDelegate {
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        //        textField.rightViewMode = .always
        //        textField.rightView = UIImageView(image: isValid ? #imageLiteral(resourceName: "success") : #imageLiteral(resourceName: "error"))
        //        print(
        //            isValid,
        //            textField.getFormattedPhoneNumber(format: .E164) ?? "E164: nil",
        //            textField.getFormattedPhoneNumber(format: .International) ?? "International: nil",
        //            textField.getFormattedPhoneNumber(format: .National) ?? "National: nil",
        //            textField.getFormattedPhoneNumber(format: .RFC3966) ?? "RFC3966: nil",
        //            textField.getRawPhoneNumber() ?? "Raw: nil"
        //        )
    }
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        let codeNum = dialCode
        countryCode = codeNum.replacingOccurrences(of: "+", with: "")

    }
}
