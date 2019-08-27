//
//  SubjectTeacherByClassContentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 19/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

protocol SubjectTeacherByClassContentCellDelegate: class {
    func pickerSelectedWithIndex(section: Int, index: Int, name: String, chapterid: String)
}

class SubjectTeacherByClassContentCell: UITableViewCell {
    
    var subjectSelected = [[Int:SubjectTeacherByClassSessionSelected]]()
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var shiftLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton! {
        didSet {
            selectButton.layer.borderWidth = 1.0
            selectButton.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.borderWidth = 1.0
            bgView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    var topicArray = [String]()
    var indexAt = Int()
    var indexSection = Int()
    var detailObj: SubjectTeacherByClassSessionListDetailChapterListModel? {
        didSet {
            cellConfig()
        }
    }
    weak var delegate: SubjectTeacherByClassContentCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        selectButton.addTarget(self, action: #selector(showTopicPicker), for: .touchUpInside)
        print("Index at: \(indexAt)")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func showTopicPicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Type -",
            rows: topicArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.selectButton.setTitle(value, for: .normal)
                let chapterID = ACData.SUBJECTTEACHERBYCLASSSESSIONLISTDATA.chapter_list[indexes].chapter_id
                self.delegate?.pickerSelectedWithIndex(section:self.indexSection, index: self.indexAt, name: value, chapterid: chapterID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        dateLabel.text = getMonth(time: obj.session_date)
        shiftLabel.text = "Shift \(obj.session_count)"
        topicArray.removeAll()
        if obj.chapter_name.isEmpty {
            selectButton.setTitle("Select Topic", for: .normal)
        } else {
            selectButton.setTitle(obj.chapter_name, for: .normal)
        }
        for (ix,k) in subjectSelected.enumerated() {
            for (j,l) in k.enumerated(){
                if indexSection == l.value.objectSection {
                    if indexAt == l.value.objectIndex {
                        selectButton.setTitle(l.value.chapter_name, for: .normal)
                    }
                }
            }
        }
        for item in ACData.SUBJECTTEACHERBYCLASSSESSIONLISTDATA.chapter_list {
            topicArray.append(item.chapter_name)
        }
    }
}

extension SubjectTeacherByClassContentCell {
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
        dateFormatterResult.dateFormat = "dd MM yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
