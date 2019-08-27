//
//  EditPaymentStudentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 28/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

protocol EditPaymentStudentCellDelegate: class {
    func studentArrayCollected(value: [StudentSetPaidModel])
}

class EditPaymentStudentCell: UITableViewCell {
    
    var isPaid = Bool()
    @IBOutlet weak var paidButton: UIButton!
    @IBOutlet weak var paidStatusIcon: UIImageView!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var studentClass: UILabel!
    @IBOutlet weak var studentNis: UILabel!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentImage: UIImageView!
    var studentPaidArray = [StudentSetPaidModel]()
    var studentObj: StudentSearchSelected? {
        didSet {
            cellConfig()
        }
    }
    var dateSelected = ""
    weak var delegate: EditPaymentStudentCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        dateButton.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        paidButton.addTarget(self, action: #selector(paidClicked), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = studentObj else { return }
        studentImage.sd_setImage(
            with: URL(string: (obj.child_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        studentName.text = obj.child_name
        studentNis.text = obj.child_nis
        studentClass.text = obj.school_class
        let dateFormatter = DateFormatter()
        let locale = Locale(identifier: "id")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = locale
        dateSelected = dateFormatter.string(from: Date())
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
                self.dateSelected = dateFormatter2.string(from: selectedDate as! Date)
                self.dateButton.setTitle(selectedDates, for: .normal)
        }, cancel: nil, origin: self)
    }
    @objc func paidClicked() {
        guard let obj = studentObj else { return }
        print(obj.child_id)
        if studentPaidArray.contains(where: {$0.child_id == obj.child_id && $0.date == dateSelected}) {
            if let index = studentPaidArray.index(where: {$0.child_id == obj.child_id && $0.date == dateSelected}) {
                studentPaidArray.remove(at: index)
            }
            self.delegate?.studentArrayCollected(value: studentPaidArray)
        } else {
            studentPaidArray.append(StudentSetPaidModel(childID: obj.child_id, date: dateSelected))
            self.delegate?.studentArrayCollected(value: studentPaidArray)
        }
    }
}
