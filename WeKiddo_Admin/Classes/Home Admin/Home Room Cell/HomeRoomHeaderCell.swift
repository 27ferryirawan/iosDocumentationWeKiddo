//
//  HomeRoomHeaderCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 17/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage
import ActionSheetPicker_3_0

protocol HomeRoomHeaderCellDelegate: class {
    func toSessionDetail()
    func toSeeMoreSession()
}

class HomeRoomHeaderCell: UITableViewCell {

    @IBOutlet weak var schoolPicker: UIButton!{
        didSet {
            schoolPicker.setTitle("Select School", for: .normal)
        }
    }
    @IBOutlet weak var schoolView: UIView! {
        didSet {
            schoolView.layer.borderColor = ACColor.MAIN.cgColor
            schoolView.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var schoolImage: UIImageView!{
        didSet{
            schoolImage.layer.borderWidth = 0.5
            schoolImage.layer.borderColor = ACColor.MAIN.cgColor
        }
    }
    @IBOutlet weak var welcomeLabel: UILabel!
    var detailObj: DashboardModel? {
        didSet {
            cellConfig()
        }
    }
    var schools: [String] = []
    weak var delegate: HomeRoomHeaderCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        welcomeLabel.text = "Welcome, \(obj.home_profile_admin_name)"
        self.schoolImage.sd_setImage(
            with: URL(string: (obj.home_profile_school_logo)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        schoolName.text = obj.home_profile_school_name
        schools.removeAll()
        for value in ACData.LOGINDATA.dashboardSchoolMenu {
            schools.append(value.school_name!)
        }
        self.schoolPicker.addTarget(self, action: #selector(showSchoolPicker), for: .touchUpInside)
    }
    @objc func showSchoolPicker() {
        ActionSheetStringPicker.show(
            withTitle: "Select Your Kids",
            rows: schools,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let schoolID = ACData.LOGINDATA.dashboardSchoolMenu[indexes].school_id, let schoolName = values else {
                    return
                }
                self.getSchoolData(schoolID: schoolID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    func getSchoolData(schoolID: String) {
        
    }
}

extension HomeRoomHeaderCell {
    func toDateString(time: String) -> String {
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
