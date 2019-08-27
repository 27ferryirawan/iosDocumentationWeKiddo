//
//  AnnouncementSubjectCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 21/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol AnnouncementSubjectDelegate: class {
    func goToAnnouncementDetail()
    func goToApprovalDetail()
}

class AnnouncementSubjectCell: UITableViewCell {

    @IBOutlet weak var announcementButton: UIButton!
    @IBOutlet weak var announcementContent: UILabel!
    @IBOutlet weak var announcementDate: UILabel!
    @IBOutlet weak var roundedSquare: UIView! {
        didSet {
            roundedSquare.layer.cornerRadius = roundedSquare.frame.size.width/2
            roundedSquare.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var announcementList: UIView! {
        didSet{
            announcementList.setBorderShadow(color: UIColor.gray, shadowRadius: 5, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    var announcementObjc: AnnouncementListModel?{
        didSet {
            cellDataSet()
        }
    }
    weak var delegate: AnnouncementSubjectDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        announcementButton.addTarget(self, action: #selector(goToDetail), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellDataSet() {
        guard let obj = announcementObjc else { return }
        announcementDate.text = toDateString(time: obj.start_date)
        announcementContent.text = obj.school_announcement_content
    }
    @objc func goToDetail() {
        guard let obj = announcementObjc else {
            return
        }
        ACRequest.GET_ANNOUNCEMENT_DETAIL(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, announcementID: obj.school_announcement_id, accessToken: ACData.LOGINDATA.accessToken, successCompletion: { (announcementDetaildata) in
            SVProgressHUD.dismiss()
            ACData.ANNOUNCEMENTDETAILDATA = announcementDetaildata
            self.delegate?.goToAnnouncementDetail()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}

extension AnnouncementSubjectCell {
    func toDateString(time: String) -> String {
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
        dateFormatterResult.dateFormat = "dd MMM yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
