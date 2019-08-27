//
//  OTPViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 13/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol OTPViewControllerDelegate: class {
    func autoRefreshPrevActivity(/*parentID: String, parentName: String, parentPhone: String, parentEmail: String, parentAddress: String, parentOccupation: String, parentCompany: String, parentPosition: String, parentImage: String*/)
//    func autoRefreshPrevActivity(/*childID: String, childName: String, childPhone: String, childEmail: String, childAddress: String, childBOD: String, childImage: String*/)
}

class OTPViewController: UIViewController {
    
    @IBOutlet weak var availableLabel: UILabel! {
        didSet {
            availableLabel.text = "Available for resend 6 digit pin in"
        }
    }
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var fieldSixTxt: UITextField!
    @IBOutlet weak var fieldFiveTxt: UITextField!
    @IBOutlet weak var fieldFourTxt: UITextField!
    @IBOutlet weak var fieldThreeTxt: UITextField!
    @IBOutlet weak var fieldTwoTxt: UITextField!
    @IBOutlet weak var fieldOneTxt: UITextField!
    @IBOutlet weak var verifyBtn: UIButton! {
        didSet {
            verifyBtn.layer.cornerRadius = 5
            verifyBtn.clipsToBounds = true
            verifyBtn.setTitle("Verify", for: .normal)
            verifyBtn.backgroundColor = ACColor.MAIN
        }
    }
    @IBOutlet weak var resendPinBtn: UIButton! {
        didSet {
            resendPinBtn.layer.cornerRadius = 5
            resendPinBtn.clipsToBounds = true
            resendPinBtn.setTitle("Resend Pin", for: .normal)
        }
    }
    @IBOutlet weak var pleaseInputLabel: UILabel! {
        didSet {
            pleaseInputLabel.text = "Please input 6 digit pin, we sent to you"
        }
    }
    weak var delegate: OTPViewControllerDelegate?
    
//    var parentID = ""
//    var parentName = ""
//    var parentPhone = ""
//    var parentEmail = ""
//    var parentAddress = ""
//    var parentOccupation = ""
//    var parentCompany = ""
//    var parentPosition = ""
//    var parentImage = ""
//
//    var childID = ""
//    var childName = ""
//    var childPhone = ""
//    var childEmail = ""
//    var childAddress = ""
//    var childBOD = ""
//    var childImage = ""
    
    var phone = ""
    var seconds = 30
    var timer = Timer()
    var isTimerRunning = false
    var fromEditProfile = false
    var fromStudent = false
    override func viewDidLoad() {
        super.viewDidLoad()
        runTimer()
        configNavigation()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if fromEditProfile {
            self.delegate?.autoRefreshPrevActivity()
        }
    }
    func configNavigation() {
        self.navigationController?.isNavigationBarHidden = false
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Change Password", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func runTimer() {
        seconds = 30
        resendPinBtn.backgroundColor = .lightGray
        resendPinBtn.isUserInteractionEnabled = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        seconds -= 1
        secondLabel.text = "\(seconds) Second"
        if seconds == 0 {
            timer.invalidate()
            resendPinBtn.backgroundColor = ACColor.MAIN
            resendPinBtn.isUserInteractionEnabled = true
        }
    }
    @IBAction func verify(_ sender: UIButton) {
        guard let first = fieldOneTxt.text, let two = fieldTwoTxt.text, let three = fieldThreeTxt.text, let four = fieldFourTxt.text, let five = fieldFiveTxt.text, let six = fieldSixTxt.text else {
            return
        }
        let defaults = UserDefaults.standard
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: defaults.string(forKey: "authVID")!, verificationCode: first+two+three+four+five+six)
        Auth.auth().signInAndRetrieveData(with: credential, completion: { (user, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                if self.fromEditProfile {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    let createNewVC = CreateNewPasswordViewController()
                    createNewVC.phoneNumber = self.phone
                    self.navigationController?.pushViewController(createNewVC, animated: true)
                }
            }
        })
    }
    @IBAction func resendPin(_ sender: UIButton) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            let defaults = UserDefaults.standard
            defaults.set(verificationID, forKey: "authVID")
            self.runTimer()
        }
    }
}
extension OTPViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fieldOneTxt {
            fieldTwoTxt.becomeFirstResponder()
        } else if textField == fieldTwoTxt {
            fieldThreeTxt.becomeFirstResponder()
        } else if textField == fieldThreeTxt {
            fieldFourTxt.becomeFirstResponder()
        } else if textField == fieldFourTxt {
            fieldFiveTxt.becomeFirstResponder()
        } else if textField == fieldFiveTxt {
            fieldSixTxt.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textField.shouldChangeCustomOtp(textField: textField, string: string)
    }
}
