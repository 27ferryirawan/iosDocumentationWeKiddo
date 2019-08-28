//
//  HomeLatePaymentCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

protocol HomeLatePaymentCellDelegate: class {
    func toDetailLatePayment()
}

class HomeLatePaymentCell: UITableViewCell {

    @IBOutlet weak var contentButton: UIButton!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color:  UIColor.gray, shadowRadius: 3.0, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    var detailObj: DashboardModelSessionCheckList? {
        didSet {
            cellConfig()
        }
    }
    weak var delegate: HomeLatePaymentCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        contentButton.addTarget(self, action: #selector(goToDetail), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func goToDetail() {
//        guard let obj = detailObj else { return }
//        ACRequest.POST_LATE_PAYMENT_DETAIL(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, childPaymentID: obj.child_payment_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (detailData) in
//            ACData.LATEPAYMENTDETAILDATA = detailData
//            SVProgressHUD.dismiss()
//            self.delegate?.toDetailLatePayment()
//        }) { (message) in
//            SVProgressHUD.dismiss()
//            ACAlert.show(message: message)
//        }
        self.delegate?.toDetailLatePayment()
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
//        contentImage.sd_setImage(
//            with: URL(string: obj.im),
//            placeholderImage: UIImage(named: "WeKiddoLogo"),
//            options: .refreshCached
//        )
//        nameLabel.text = obj.child_name
//        classLabel.text = obj.school_class
//        dayLabel.text = "\(getDay(time: obj.due_date))"
//        monthLabel.text = "\(getMonth(time: obj.due_date))"
//        yearLabel.text = "\(getYear(time: obj.due_date))"
    }
}

extension HomeLatePaymentCell {
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
    
    func getWeekDay(time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "EEE"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
    func getYear(time: String) -> String {
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
        dateFormatterResult.dateFormat = "yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
