//
//  HistoryListCell.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 31/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class HistoryListCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var historyLbl: UILabel!
    @IBOutlet weak var userLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var historyObjc: HistoryListModel? {
        didSet {
            cellDataSet()
        }
    }
    func cellDataSet() {
        guard let obj = historyObjc else { return }
        dateLbl.text = getTimestamp(time: obj.log_date)
        historyLbl.text = obj.activity_log
        userLbl.text = obj.name
    }
    
}
extension HistoryListCell {
    
    func getTimestamp(time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "yyyy-MM-dd h.mm a"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
