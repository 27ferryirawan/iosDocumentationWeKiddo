//
//  AbsenceDetailCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 30/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import SDWebImage

protocol AbsenceDetailCellDelegate: class {
    func confirmProcees(withChildID: String, withAbsenceTime: String, withStatusAbsence: Int, withReason: String, withDesc: String)
}

class AbsenceDetailCell: UITableViewCell {

    @IBOutlet weak var minuteButtonPicker: UIButton!
    @IBOutlet weak var hourButtonPicker: UIButton!
    var placeholderLabel = UILabel()
    var selectedReason = ""
    var reasonDesc = ""
    var selectedAbsenceTime = ""
    @IBOutlet weak var checkInButton: UIButton! {
        didSet {
            checkInButton.layer.cornerRadius = 5.0
            checkInButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var reasonText: UITextView! {
        didSet {
            reasonText.layer.borderColor = UIColor.groupTableViewBackground.cgColor
            reasonText.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var reasonPickerButton: UIButton! {
        didSet {
            reasonPickerButton.layer.borderColor = UIColor.groupTableViewBackground.cgColor
            reasonPickerButton.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var absenceStatus: UILabel!
    @IBOutlet weak var absenceView: UIView! {
        didSet {
            absenceView.layer.cornerRadius = 5.0
            absenceView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var studentClass: UILabel!
    @IBOutlet weak var studentNIS: UILabel!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentImage: UIImageView!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color: UIColor.lightGray, shadowRadius: 3.0, shadowOpactiy: 1.0, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    var reason = [String]()
    var detailAbsence: AbsenceDetailModel? {
        didSet {
            cellConfig()
        }
    }
    weak var delegate: AbsenceDetailCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        checkInButton.addTarget(self, action: #selector(checkInSubmit), for: .touchUpInside)
        reasonPickerButton.addTarget(self, action: #selector(showReason), for: .touchUpInside)
        hourButtonPicker.addTarget(self, action: #selector(showTimePicker), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailAbsence else { return }
        studentImage.sd_setImage(
            with: URL(string: (obj.child_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        studentName.text = obj.child_name
        studentNIS.text = obj.child_nis
        studentClass.text = obj.school_class
        if obj.status_absence == 0 {
            absenceStatus.text = "Check Out"
        } else {
            absenceStatus.text = "Check In"
        }
        for item in obj.reasons {
            reason.append(item.reason_desc)
        }
    }
    @objc func checkInSubmit() {
        guard let obj = detailAbsence else { return }
        self.delegate?.confirmProcees(withChildID: obj.child_id, withAbsenceTime: selectedAbsenceTime, withStatusAbsence: obj.status_absence, withReason: self.selectedReason, withDesc: reasonDesc)
    }
    @objc func showReason() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Reason -",
            rows: reason,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                print(value)
                guard let obj = self.detailAbsence else { return }
                self.selectedReason = obj.reasons[indexes].reason_id
                DispatchQueue.main.async {
                    self.reasonPickerButton.setTitle("  \(value)", for: .normal)
                }
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func showTimePicker() {
        ActionSheetDatePicker.show(
            withTitle: "- Select Time -",
            datePickerMode: .time,
            selectedDate: Date(),
            doneBlock: { picker, selectedDate, origin in
                let dateFormatter = DateFormatter()
                let hourFormatter = DateFormatter()
                let minuteFormatter = DateFormatter()
                let locale = Locale(identifier: "id")
                dateFormatter.dateFormat = "HH:mm:ss"
                hourFormatter.dateFormat = "HH"
                minuteFormatter.dateFormat = "mm"
                dateFormatter.locale = locale
                hourFormatter.locale = locale
                minuteFormatter.locale = locale
                let selectedDates = dateFormatter.string(from: selectedDate as! Date)
                self.selectedAbsenceTime = selectedDates
                let selectedHour = hourFormatter.string(from: selectedDate as! Date)
                let selectedMinute = minuteFormatter.string(from: selectedDate as! Date)
                self.hourButtonPicker.setTitle(selectedHour, for: .normal)
                self.minuteButtonPicker.setTitle(selectedMinute, for: .normal)
        }, cancel: nil, origin: self)

    }
}

extension AbsenceDetailCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            reasonDesc = text
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
        reasonDesc = textView.text!
        if textView.text.isEmpty {
            textView.text = "Reason"
            textView.textColor = UIColor.lightGray
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !reasonText.text.isEmpty
    }

}
