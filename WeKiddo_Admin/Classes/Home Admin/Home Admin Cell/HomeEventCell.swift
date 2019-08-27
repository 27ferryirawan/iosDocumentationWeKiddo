//
//  HomeEventCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol HomeEventCellDelegate: class {
    func toDetailEvent()
}

class HomeEventCell: UITableViewCell {

    @IBOutlet weak var roundedOne: UIView!{
        didSet{
            roundedOne.layer.cornerRadius = roundedOne.frame.size.width/2
        }
    }
    @IBOutlet weak var roundedTwo: UIView!{
        didSet{
            roundedTwo.layer.cornerRadius = roundedTwo.frame.size.width/2
        }
    }
    @IBOutlet weak var roundedThree: UIView!{
        didSet{
            roundedThree.layer.cornerRadius = roundedThree.frame.size.width/2
        }
    }
    @IBOutlet weak var roundedFour: UIView!{
        didSet{
            roundedFour.layer.cornerRadius = roundedFour.frame.size.width/2
        }
    }
    @IBOutlet weak var eventButton: UIButton!
    @IBOutlet weak var paidLabel: UILabel!
    @IBOutlet weak var approveLabel: UILabel!
    @IBOutlet weak var rejectLabel: UILabel!
    @IBOutlet weak var pendingLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color:  UIColor.gray, shadowRadius: 3.0, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    var eventObj: DashboardModelEventMonitoring? {
        didSet {
            cellConfig()
        }
    }
    var listObj: AdminEventListModel? {
        didSet {
            cellDataSet()
        }
    }
    weak var delegate: HomeEventCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        eventButton.addTarget(self, action: #selector(toDetailEvent), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = eventObj else { return }
        dateLabel.text = "\(getMonth(time: obj.start_event_date)) | Total : \(obj.count_total)"
        subjectLabel.text = obj.event_name
        pendingLabel.text = obj.count_pending
        approveLabel.text = obj.count_approve
        rejectLabel.text = obj.count_reject
    }
    func cellDataSet() {
        guard let obj = listObj else { return }
        dateLabel.text = "\(getMonth(time: obj.start_event_date)) | Total : \(obj.count_total)"
        subjectLabel.text = obj.event_name
        pendingLabel.text = "\(obj.count_pending)"
        approveLabel.text = "\(obj.count_approve)"
        rejectLabel.text = "\(obj.count_reject)"
    }
    @objc func toDetailEvent() {
        guard let obj = listObj else { return }
        ACRequest.POST_ADMIN_DETAIL_EVENT(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, eventID: obj.event_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
            SVProgressHUD.dismiss()
            ACData.APPROVALDETAILDATA = jsonDatas
            self.delegate?.toDetailEvent()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}

extension HomeEventCell {
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
        dateFormatterResult.dateFormat = "dd MM yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
