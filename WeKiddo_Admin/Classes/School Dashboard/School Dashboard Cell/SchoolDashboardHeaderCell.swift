//
//  SchoolDashboardHeaderCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 21/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit

class SchoolDashboardHeaderCell: UITableViewCell {

    @IBOutlet weak var today: UILabel!
    @IBOutlet weak var dateToday: UILabel!
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var schoolClass: UILabel!
    @IBOutlet weak var schoolImage: UIImageView!
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
    
    var detailObj: DashboardDetailSchoolModel? {
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
    
    func cellConfig() {
        guard let obj = detailObj else { return }
        self.schoolImage.sd_setImage(
            with: URL(string: (obj.school_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        schoolName.text = obj.school_name
        schoolClass.text = "School | \(obj.school_grade)"
        today.text = obj.day
        dateToday.text = convertDate(time: obj.date)
    }
    
}

extension SchoolDashboardHeaderCell {
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
