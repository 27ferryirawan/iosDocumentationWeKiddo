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

class AbsenceDetailCell: UITableViewCell {

    @IBOutlet weak var minuteButtonPicker: UIButton!
    @IBOutlet weak var hourButtonPicker: UIButton!
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
    }
    @objc func checkInSubmit() {
        
    }
    @objc func showReason() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Reason -",
            rows: reason,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.reasonPickerButton.setTitle(value, for: .normal)
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
                let locale = Locale(identifier: "id")
                dateFormatter.dateFormat = "HH:mm"
                dateFormatter.locale = locale
                let selectedDates = dateFormatter.string(from: selectedDate as! Date)
                print(selectedDates)
        }, cancel: nil, origin: self)

    }
}
