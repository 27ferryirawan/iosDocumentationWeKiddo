//
//  AssignmentDetailClassCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 05/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class AssignmentDetailClassCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    var detailObj: AssignmentDetailSchoolClassModel? {
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
        classLabel.text = obj.school_class
        dateLabel.text = getMonth(time: obj.due_date)
    }
}

extension AssignmentDetailClassCell {
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
        dateFormatterResult.dateFormat = "dd-MM-yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
