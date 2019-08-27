//
//  AddNewPermissionCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 08/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import SVProgressHUD

protocol AddNewPermissionCellDelegate: class {
    func dateSelected(date: String)
    func typeSelected(type: String)
    func reasonFilled(reason: String)
}

class AddNewPermissionCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var discardButton: UIButton!
    @IBOutlet weak var selectAttachmentButton: UIButton!
    @IBOutlet weak var reasonTextfield: UITextField!
    @IBOutlet weak var selectTypeButton: UIButton!
    @IBOutlet weak var selectDateButton: UIButton!
    var permissionType: [String] = ["Sick", "Leave"]
    weak var delegate: AddNewPermissionCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        selectDateButton.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        selectTypeButton.addTarget(self, action: #selector(showTypePicker), for: .touchUpInside)
//        selectAttachmentButton.addTarget(self, action: #selector(showAttachmentPicker), for: .touchUpInside)
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
                let locale = Locale(identifier: "id")
                dateFormatter.dateFormat = "yyyy-MM-dd"
                dateFormatter.locale = locale
                let selectedDate = dateFormatter.string(from: selectedDate as! Date)
                self.selectDateButton.setTitle(selectedDate, for: .normal)
                self.delegate?.dateSelected(date: selectedDate)
        }, cancel: nil, origin: self)
    }
    @objc func showTypePicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Type -",
            rows: permissionType,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.selectTypeButton.setTitle(value, for: .normal)
                self.delegate?.typeSelected(type: value)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.reasonFilled(reason: textField.text!)
    }
}
