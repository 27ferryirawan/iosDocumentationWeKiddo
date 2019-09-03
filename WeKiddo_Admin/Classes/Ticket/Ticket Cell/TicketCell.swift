//
//  TicketCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 03/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol TicketCellDelegate: class {
    func toTicketDetail()
}

class TicketCell: UITableViewCell {

    @IBOutlet weak var contentButton: UIButton!
    @IBOutlet weak var contentMessage: UILabel!
    @IBOutlet weak var contentDate: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color: UIColor.lightGray, shadowRadius: 3.0, shadowOpactiy: 1.0, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    var detailObj: TicketPendingModel? {
        didSet {
            cellConfig()
        }
    }
    weak var delegate: TicketCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        contentButton.addTarget(self, action: #selector(fetchDetail), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func fetchDetail() {
        guard let obj = detailObj else { return }
        ACRequest.POST_TICKET_DETAIL(userId: ACData.LOGINDATA.userID, ticketID: obj.ticket_id, schoolID: ACData.DASHBOARDDATA.home_profile_school_id, yearID: ACData.DASHBOARDDATA.home_profile_year_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (result) in
            ACData.DETAILTICKETDATA = result
            SVProgressHUD.dismiss()
            self.delegate?.toTicketDetail()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        contentMessage.text = obj.title
        contentDate.text = "\(obj.ticket_id) | \(getMonth(time: obj.created_at))"
    }
}

extension TicketCell {
    func getMonth(time: String) -> String {
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
        dateFormatterResult.dateFormat = "dd MMM yyyy - HH:mm"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
