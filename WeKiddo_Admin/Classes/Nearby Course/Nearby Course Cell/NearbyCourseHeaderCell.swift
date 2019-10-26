//
//  NearbyCourseHeaderCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 25/10/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage
import ActionSheetPicker_3_0

protocol NearbyCourseHeaderCellDelegate: class {
    func toSessionDetail()
    func toSeeMoreSession()
    func refreshData()
}

class NearbyCourseHeaderCell: UITableViewCell {

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
    @IBOutlet weak var searchBar: UISearchBar!
    var detailObj: NearbyModel? {
        didSet {
            cellConfig()
        }
    }
    var schools: [String] = []
    weak var delegate: NearbyCourseHeaderCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        self.schoolImage.sd_setImage(
            with: URL(string: (obj.school_logo)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        schoolName.text = obj.school_name
        schools.removeAll()
        for value in ACData.NEARBYDATA.school_list {
            schools.append(value.school_name)
        }
        self.schoolPicker.addTarget(self, action: #selector(showSchoolPicker), for: .touchUpInside)
    }
    @objc func showSchoolPicker() {
        ActionSheetStringPicker.show(
            withTitle: "Select School",
            rows: schools,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.schoolPicker.setTitle(value, for: .normal)
                guard let schoolID = ACData.NEARBYDATA.school_list[indexes].school_id, let yearId = ACData.NEARBYDATA.school_list[indexes].year_id else {
                    return
                }
                self.getSchoolData(schoolID: schoolID, yearID: yearId)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    func getSchoolData(schoolID: String, yearID: String) {
        ACRequest.GET_NEARBY_DATA(userID: ACData.LOGINDATA.userID, schoolID: schoolID, yearID: yearID, keyword: "", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (result) in
            SVProgressHUD.dismiss()
            ACData.NEARBYDATA = result
            self.delegate?.refreshData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}

extension NearbyCourseHeaderCell {
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
