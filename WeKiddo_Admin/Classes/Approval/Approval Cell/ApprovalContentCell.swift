//
//  ApprovalContentCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 05/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol ApprovalContentCellDelegate: class {
    func goToDetail()
}

class ApprovalContentCell: UITableViewCell {

    @IBOutlet weak var approvalButton: UIButton!
    @IBOutlet weak var approvalStatusImage: UIImageView!
    @IBOutlet weak var approvalContentLbl: UILabel!
    @IBOutlet weak var approvalDateLbl: UILabel!
    @IBOutlet weak var roundedSquare: UIView!{
        didSet {
            roundedSquare.layer.cornerRadius = roundedSquare.frame.size.width/2
            roundedSquare.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var approvalList: UIView!{
        didSet{
            approvalList.setBorderShadow(color: UIColor.gray, shadowRadius: 5, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    weak var delegate: ApprovalContentCellDelegate?
    var approvalObjc: ApprovalModel?{
        didSet{
            cellDataSet()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        approvalButton.addTarget(self, action: #selector(fetchDetail), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellDataSet() {
        guard let obj = approvalObjc else {
            return
        }
        approvalDateLbl.text = toDateString(time: obj.start_event_date)
        approvalContentLbl.text = obj.event_name
    }
    @objc func fetchDetail() {
        guard let obj = approvalObjc else {
            return
        }
        ACRequest.GET_EVENT_APPROVAL_DETAIL(eventID: obj.event_id, childID: ACData.HOMEDATA.childID, successCompletion: { (approvalDetailData) in
            ACData.APPROVALDETAILDATA = approvalDetailData
            SVProgressHUD.dismiss()
            self.delegate?.goToDetail()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
}

extension ApprovalContentCell {
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
