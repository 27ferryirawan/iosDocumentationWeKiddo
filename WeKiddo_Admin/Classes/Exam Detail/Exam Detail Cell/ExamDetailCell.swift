//
//  ExamDetailCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 08/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class ExamDetailCell: UITableViewCell {

    @IBOutlet weak var examDescLabel: UILabel!
    @IBOutlet weak var examTypeLabel: UILabel!
    @IBOutlet weak var examTopicLabel: UILabel!
    @IBOutlet weak var examDateLabel: UILabel!
    var examObj: ExamDetailModel? {
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
        guard let obj = examObj else {
            return
        }
        examDateLabel.text = "\(convertDate(time: obj.session_date)) AM | \(obj.subject_name)"
        examTopicLabel.text = obj.subject_name
        examTypeLabel.text = "Type : \(obj.score_type_name)"
        examDescLabel.text = obj.chapter_desc
    }
}

extension ExamDetailCell {
    func convertDate(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        // then convert date to string again
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "EEEE, dd MMMM yyyy - HH:mm"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}

