//
//  LatePaymentContentCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD

protocol LatePaymentContentCellDelegate: class {
    func toDetailLatePayment()
}

class LatePaymentContentCell: UITableViewCell {

    @IBOutlet weak var dateYearLabel: UILabel!
    @IBOutlet weak var dateMonthLable: UILabel!
    @IBOutlet weak var dateNumberLabel: UILabel!
    @IBOutlet weak var tuitionLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color: UIColor.gray, shadowRadius: 2.0, shadowOpactiy: 1.0, shadowOffsetWidth: 2, shadowOffsetHeight: 2)
        }
    }
    var detailObj: LatePaymentListModel? {
        didSet {
            cellConfig()
        }
    }
    weak var delegate: LatePaymentContentCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func toDetail(_ sender: Any) {
        guard let obj = detailObj else { return }
        ACRequest.POST_LATE_PAYMENT_DETAIL(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, childPaymentID: obj.child_payment_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (detailData) in
            ACData.LATEPAYMENTDETAILDATA = detailData
            SVProgressHUD.dismiss()
            self.delegate?.toDetailLatePayment()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        nameLabel.text = obj.child_name
        classLabel.text = obj.school_class
        dateNumberLabel.text = "\(getDay(time: obj.due_date))"
        dateMonthLable.text = "\(getMonth(time: obj.due_date))"
        dateYearLabel.text = "\(getYear(time: obj.due_date))"
        switch obj.payment_type {
        case 1:
            tuitionLabel.text = "Registration Fee"
        case 2:
            tuitionLabel.text = "Administration Fee"
        case 3:
            tuitionLabel.text = "Tution Fee"
        case 4:
            tuitionLabel.text = "Text Book Fee"
        case 5:
            tuitionLabel.text = "Others"
        default:
            tuitionLabel.text = ""
        }
    }
}

extension LatePaymentContentCell {
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
