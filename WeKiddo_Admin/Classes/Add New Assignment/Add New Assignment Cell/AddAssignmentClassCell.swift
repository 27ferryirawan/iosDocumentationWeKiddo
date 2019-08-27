//
//  AddAssignmentClassCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 05/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

protocol AddAssignmentClassCellDelegate: class {
    func classSelected(atIndex: Int, value: String)
    func dateSelected(atIndex: Int, value: String)
}

class AddAssignmentClassCell: UITableViewCell {
    
    @IBOutlet weak var datePickerButton: UIButton!
    @IBOutlet weak var classPickerButton: UIButton!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color: UIColor.gray, shadowRadius: 1.0, shadowOpactiy: 0.5, shadowOffsetWidth: 1, shadowOffsetHeight: 1)
        }
    }
    var className = [String]()
    var indexArray = 0
    var isFromEdit = Bool()
    var array = [ClassModel]()
    var editObj: AssignmentDetailEditModel? {
        didSet {
            cellEditConfig()
        }
    }
    var obj: ChapterModel? {
        didSet {
            cellConfig()
        }
    }
    weak var delegate: AddAssignmentClassCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        classPickerButton.addTarget(self, action: #selector(showClassPicker), for: .touchUpInside)
        datePickerButton.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        isFromEdit = false
        className.removeAll()
        for index in obj!.class_list {
            className.append(index.school_class)
        }
    }
    func cellEditConfig() {
        isFromEdit = true
        className.removeAll()
        for index in editObj!.schoolClass {
            className.append(index.school_class)
        }
        
        if let classData = editObj?.school_class_list.first {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            classPickerButton.setTitle(classData.school_class, for: .normal)
            let thedate = dateFormatter.date(from: classData.due_date)
            dateFormatter.dateFormat = "dd/MM/yyyy"
            datePickerButton.setTitle(dateFormatter.string(from: thedate!), for: .normal)
        }
    }
    @objc func showClassPicker() {
        ActionSheetStringPicker.show(
            withTitle: "Select Class",
            rows: className,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values else { return }
                
                for index in self.array {
                    if index.school_class_id == "\(value)" {
                        print(index.school_class_id)
                        print(value)
                        ACAlert.show(message: "Can not choose same class")
                    } else {
                        if self.isFromEdit {
                            let classID = ACData.ASSIGNMENTDETAILEDITDATA.schoolClass[indexes].school_class_id
                            self.classPickerButton.setTitle("\(value)", for: .normal)
                            self.delegate?.classSelected(atIndex: self.indexArray, value: classID)
                        } else {
                            let classID = ACData.CHAPTERDATA.class_list[indexes].school_class_id
                            self.classPickerButton.setTitle("\(value)", for: .normal)
                            self.delegate?.classSelected(atIndex: self.indexArray, value: classID)
                        }
                    }
                }
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
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
                self.datePickerButton.setTitle(selectedDates, for: .normal)
                self.delegate?.dateSelected(atIndex: self.indexArray, value: choosenDate)
        }, cancel: nil, origin: self)
    }
}
