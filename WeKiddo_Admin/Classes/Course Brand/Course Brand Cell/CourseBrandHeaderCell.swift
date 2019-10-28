//
//  CourseBrandHeaderCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 26/10/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage
import ActionSheetPicker_3_0

protocol CourseBrandHeaderCellDelegate: class {
    func toSessionDetail()
    func toSeeMoreSession()
    func refreshData()
}

class CourseBrandHeaderCell: UITableViewCell {

    @IBOutlet weak var schoolPicker: UIButton!{
        didSet {
            schoolPicker.setTitle("Select Brand", for: .normal)
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    var detailObj: NearbyModel? {
        didSet {
            cellConfig()
        }
    }
    var brands: [String] = []
    weak var delegate: CourseBrandHeaderCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        brands.removeAll()
        for value in ACData.NEARBYDATA.school_list {
            brands.append(value.school_name)
        }
        self.schoolPicker.addTarget(self, action: #selector(showSchoolPicker), for: .touchUpInside)
    }
    @objc func showSchoolPicker() {
        ActionSheetStringPicker.show(
            withTitle: "Select School",
            rows: brands,
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
//            self.delegate?.refreshData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}

extension CourseBrandHeaderCell {
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
