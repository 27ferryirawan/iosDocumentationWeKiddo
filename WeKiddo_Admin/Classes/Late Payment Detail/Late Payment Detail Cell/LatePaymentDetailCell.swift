//
//  LatePaymentDetailCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 17/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

protocol LatePaymentDetailCellDelegate: class {
    func setPaid(withDate: String, withNotes: String, withPaymentID: String)
    func reasonFilled(reason: String)
}

class LatePaymentDetailCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var paidButton: UIButton!
    @IBOutlet weak var notesText: UITextView! {
        didSet {
            notesText.textColor = UIColor.lightGray
        }
    }
    @IBOutlet weak var datePickerButton: UIButton!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var paymentChargeLabel: UILabel!
    @IBOutlet weak var dateYearLabel: UILabel!
    @IBOutlet weak var dateMonthLabel: UILabel!
    @IBOutlet weak var dateNumberLabel: UILabel!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var feeType: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    private var reason = ""
    private var dateSelected = ""
    weak var delegate: LatePaymentDetailCellDelegate?
    var detailObj: LatePaymentDetailModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        datePickerButton.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        paidButton.addTarget(self, action: #selector(confirmStatusToPaid)
            , for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        nameLabel.text = obj.child_name
        classLabel.text = obj.school_class
        switch obj.payment_type {
        case 1:
            feeType.text = "Registration Fee"
        case 2:
            feeType.text = "Administration Fee"
        case 3:
            feeType.text = "Tution Fee"
        case 4:
            feeType.text = "Text Book Fee"
        case 5:
            feeType.text = "Others"
        default:
            feeType.text = ""
        }
        dateNumberLabel.text = "\(getDay(time: obj.due_date))"
        dateMonthLabel.text = "\(getMonth(time: obj.due_date))"
        dateYearLabel.text = "\(getYear(time: obj.due_date))"
        paymentChargeLabel.text = obj.amount
        descLabel.text = obj.desc
        datePickerButton.setTitle(obj.due_date, for: .normal
        )
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
                dateFormatter.dateFormat = "dd/MM/yyyy"
                dateFormatter2.dateFormat = "yyyy-MM-dd"
                dateFormatter.locale = locale
                dateFormatter2.locale = locale
                let selectedDates = dateFormatter.string(from: selectedDate as! Date)
                let choosenDate = dateFormatter2.string(from: selectedDate as! Date)
                self.dateSelected = choosenDate
                self.datePickerButton.setTitle(selectedDates, for: .normal)
        }, cancel: nil, origin: self)
    }
    @objc func confirmStatusToPaid() {
        print("date: \(dateSelected), notes: \(reason)")
        guard let obj = detailObj else { return }
        self.delegate?.setPaid(withDate: dateSelected, withNotes: reason, withPaymentID: obj.child_payment_id)
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            reason = textView.text!
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
            textView.text = "Reason"
            textView.textColor = UIColor.lightGray
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        reason = textView.text!
        self.delegate?.reasonFilled(reason: reason)
    }
}

extension LatePaymentDetailCell {
    func getMonth(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        // then convert date to string again
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "LLLL"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
    
    func getDay(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        // then convert date to string again
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "dd"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
    
    func getWeekDay(time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "EEE"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
    func getYear(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        // then convert date to string again
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
