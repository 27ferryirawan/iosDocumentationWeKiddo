//
//  AttendanceSubjectCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 20/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol AttendanceSubjectCellDelegate: class {
    func toDetail()
}

class AttendanceSubjectCell: UITableViewCell {

    @IBOutlet weak var attendanceButton: UIButton!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var shiftLabel: UILabel!
    @IBOutlet weak var subjectLbl: UILabel!
    @IBOutlet weak var attendanceList: UIView!{
        didSet{
            attendanceList.setBorderShadow(color: UIColor.gray, shadowRadius: 3, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    var todayObj: AttendanceModel? {
        didSet {
            cellConfigs()
        }
    }
    weak var delegate: AttendanceSubjectCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        attendanceButton.addTarget(self, action: #selector(goToDetail), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfigs() {
        guard let obj = todayObj else {
            return
        }
        subjectLbl.text = obj.subject_name
        classLabel.text = obj.school_class
        shiftLabel.text = obj.subject_id
        timeLabel.text = "\(getTime(time: obj.start_time)) - \(getTime(time: obj.end_time))"
    }
    @objc func goToDetail() {
        guard let obj = todayObj else {
            return
        }
        ACRequest.POST_DETAIL_ATTENDANCE(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, tokenAccess: ACData.LOGINDATA.accessToken, schoolSessionID: obj.school_session_id, successCompletion: { (detailData) in
            ACData.ATTENDANCEDETAILDATA = detailData
            SVProgressHUD.dismiss()
            self.delegate?.toDetail()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
}

extension AttendanceSubjectCell {
    func getTime(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm:ss"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        // then convert date to string again
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "HH:mm"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
