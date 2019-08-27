//
//  NotificationCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 17/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var notificationClass: UILabel!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var notificationContent: UILabel!
    @IBOutlet weak var notificationDate: UILabel!
    @IBOutlet weak var notificationIcon: UIImageView!
    @IBOutlet weak var notificationList: UIView!{
        didSet{
            notificationList.setBorderShadow(color: UIColor.gray, shadowRadius: 5, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    var notificationObj: NotificationModel? {
        didSet {
            configCell()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        notificationButton.addTarget(self, action: #selector(fetchDetail), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configCell() {
        guard let obj = notificationObj else {
            return
        }
        notificationDate.text = convertDate(time: obj.created_at)
        notificationContent.text = obj.notification_type
        if obj.notification_type.contains("COMPETITION") {
            notificationIcon.image = UIImage(named: "ic_competition")
        } else {
            notificationIcon.image = UIImage(named: "icon_announcement_notification")
        }
    }
    @objc func fetchDetail() {
        
    }
}

extension NotificationCell {
    func convertDate(time: String) -> String {
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
        dateFormatterResult.dateFormat = "dd MMMM yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
