//
//  DetailTaskAdminHistoryCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 02/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class DetailTaskAdminHistoryCell: UITableViewCell {

    @IBOutlet weak var contentText: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    var detailObj: DetailTaskAdminModel? {
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
        contentText.text = obj.title
        dateLabel.text = getMonth(time: obj.task_date)
    }
}

extension DetailTaskAdminHistoryCell {
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
        dateFormatterResult.dateFormat = "dd MMM yyyy HH:mm"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
