//
//  SubjectTeacherByClassHeaderCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 19/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class SubjectTeacherByClassHeaderCell: UITableViewCell {

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    var detailObj: SubjectTeacherByClassSessionListDetailModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        titleText.text = "Week \(obj.week_count)"
        subTitleLabel.text = "\(getDay(time: obj.from_date)) - \(getDay(time: obj.end_date)) \(getMonth(time: obj.end_date))"
    }
}

extension SubjectTeacherByClassHeaderCell {
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
    
}
