//
//  UpcomingSessionListCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 16/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class UpcomingSessionListCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var chapterSectionLabel: UILabel!
    @IBOutlet weak var chapterNameLbl: UILabel!{
        didSet{
            chapterNameLbl.textColor = ACColor.MAIN
        }
    }
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color:  UIColor.gray, shadowRadius: 3.0, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    var detailObj: UpcomingSessionItem? {
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
        chapterNameLbl.text = obj.subject_name
        classLabel.text = obj.school_class
        timeLabel.text = "\(getDate(time: obj.start_time)) - \(getDate(time: obj.end_time))"
    }
}

extension UpcomingSessionListCell {
    func getDate(time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm:ss"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "HH:mm"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
