//
//  AddLatePaymentFormCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import SVProgressHUD
import Alamofire

protocol AddLatePaymentFormCellDelegate: class {
    func toSearchStudent()
}

class AddLatePaymentFormCell: UITableViewCell {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var descText: UITextView!
    @IBOutlet weak var amountText: UITextField!
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var dueDateButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    var permissionType: [String] = ["Registration Fee", "Administration Fee", "Tution Fee", "Text Book Fee", "Others"]
    private var dateSelected = ""
    private var paymentType = 0
    private var amount = ""
    private var desc = ""
    var studentLists = [StudentSearchSelected]()
    weak var delegate: AddLatePaymentFormCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        dueDateButton.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        titleButton.addTarget(self, action: #selector(showTypePicker), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
                dateFormatter.dateFormat = "dd / MM / yyyy"
                dateFormatter2.dateFormat = "yyyy-MM-dd"
                dateFormatter.locale = locale
                dateFormatter2.locale = locale
                let selectedDates = dateFormatter.string(from: selectedDate as! Date)
                let choosenDate = dateFormatter2.string(from: selectedDate as! Date)
                self.dueDateButton.setTitle(selectedDates, for: .normal)
                self.dateSelected = choosenDate
                
        }, cancel: nil, origin: self)
    }
    @objc func showTypePicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Type -",
            rows: permissionType,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.titleButton.setTitle(value, for: .normal)
                self.paymentType = indexes + 1
//                self.delegate?.typeSelected(type: value)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func saveData() {
        let placeData = UserDefaults.standard.data(forKey: "studentSelected")
        let placeArray = try! JSONDecoder().decode([StudentSearchSelected].self, from: placeData!)
        studentLists = placeArray

        for index in studentLists {
            print(index.child_id)
        }
        var addOn = "["
        var i = 0
        for data in studentLists {
            if i > 0 {
                addOn += ","
            }
            addOn += "{"
            addOn += "\"child_id\":\"\(data.child_id)\""
            addOn += "}"
            
            i += 1
        }
        addOn += "]"
        
        let newaddOn = addOn.replacingOccurrences(of: "\\", with: "")
        let jsonData = newaddOn.data(using: .utf8)!
        let jsonO = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
        let parameters: Parameters = [
            "user_id":ACData.LOGINDATA.userID,
            "role":ACData.LOGINDATA.role,
            "school_id":ACData.LOGINDATA.school_id,
            "year_id":ACData.LOGINDATA.year_id,
            "due_date":dateSelected,
            "payment_type":paymentType,
            "amount":amount,
            "description":desc,
            "student_list":jsonO
        ]
        print(parameters)
        ACRequest.POST_ADD_NEW_PAYMENT_LATE(params: parameters, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: status)
            UserDefaults.standard.removeObject(forKey: "studentSelected")
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}

extension AddLatePaymentFormCell: UITextFieldDelegate, UITextViewDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == amountText {
            amount = textField.text!
        } else {
            desc = textField.text!
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == amountText {
            amount = textField.text!
            descText.becomeFirstResponder()
        } else {
            desc = textField.text!
            textField.resignFirstResponder()
        }
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            desc = textView.text!
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        desc = textView.text!
    }
}
