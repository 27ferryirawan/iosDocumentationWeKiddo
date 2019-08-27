//
//  AnnouncementContentCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol AnnouncementContentDelegate: class {
    func goToAnnouncementDetail()
    func goToApprovalDetail()
}

class AnnouncementContentCell: UITableViewCell {
    @IBOutlet weak var roundedSquare: UIView!{
        didSet {
            roundedSquare.layer.cornerRadius = roundedSquare.frame.size.width/2
            roundedSquare.clipsToBounds = true
        }
    }
    @IBOutlet weak var announcementButton: UIButton!
    @IBOutlet weak var announcementDate: UILabel!
    @IBOutlet weak var announcementContent: UILabel!
    @IBOutlet weak var announcementList: UIView!{
        didSet{
            announcementList.setBorderShadow(color:  UIColor.gray, shadowRadius: 3.0, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    var announcementObjc: AnnouncementModel? {
        didSet {
            cellDataSet()
        }
    }
    weak var delegate: AnnouncementContentDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        announcementButton.addTarget(self, action: #selector(goToAnnouncementDetail), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellDataSet() {
        guard let dateStart = announcementObjc?.school_announcement_date, let subject = announcementObjc?.school_announcement_subject else {
            return
        }
        announcementDate.text = toDateString(time: dateStart)
        announcementContent.text = subject
    }
    @objc func goToAnnouncementDetail() {
        guard let obj = announcementObjc else {
            return
        }
//        ACRequest.GET_ANNOUNCEMENT_DETAIL(announcementID: obj.school_announcement_id, successCompletion: { (announceDetailData) in
//            ACData.ANNOUNCEMENTDETAILDATA = announceDetailData
//            SVProgressHUD.dismiss()
//            self.delegate?.goToAnnouncementDetail()
//        }) { (message) in
//            SVProgressHUD.dismiss()
//        }
    }
}

extension AnnouncementContentCell {
    func toDateString(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
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
