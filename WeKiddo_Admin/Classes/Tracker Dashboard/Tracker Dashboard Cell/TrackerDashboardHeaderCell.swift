//
//  TrackerDashboardHeaderCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 21/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol TrackerDashboardHeaderCellDelegate: class {
    func toTotalSchoolPage()
}

class TrackerDashboardHeaderCell: UITableViewCell {
    
    @IBOutlet weak var currentDayLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var totalSchoolLabel: UILabel!
    @IBOutlet weak var dateView: UIView! {
        didSet {
            dateView.layer.borderWidth = 1.0
            dateView.layer.borderColor = UIColor.lightGray.cgColor
            dateView.layer.cornerRadius = 5.0
            dateView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var totalSchoolView: UIView! {
        didSet {
            totalSchoolView.layer.cornerRadius = 5.0
            totalSchoolView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.borderWidth = 1.0
            bgView.layer.borderColor = UIColor.lightGray.cgColor
            bgView.layer.cornerRadius = 5.0
            bgView.layer.masksToBounds = true
        }
    }
    
    weak var delegate: TrackerDashboardHeaderCellDelegate?
    
    var detailObj: DashboardCoordinatorModel? {
        didSet {
            cellConfig()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func toTotalSchool(_ sender: UIButton) {
        guard let yearID = ACData.LOGINDATA.dashboardSchoolMenu[0].year_id else {
            return
        }
        ACData.DASHBOARDCOORDINATORSCHOOLLISTDATA.removeAll()
        ACRequest.POST_DASHBOARD_COORDINATOR_SCHOOL_LIST(userId: ACData.LOGINDATA.userID, yearID: yearID, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
            SVProgressHUD.dismiss()
            ACData.DASHBOARDCOORDINATORSCHOOLLISTDATA = results
            self.delegate?.toTotalSchoolPage()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    
    func cellConfig() {
        guard let obj = detailObj else { return }
        totalSchoolLabel.text = "\(obj.total_school)"
        todayLabel.text = convertDate(time: obj.date)
        currentDayLabel.text = obj.day
    }
}

extension TrackerDashboardHeaderCell {
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
