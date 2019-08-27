//
//  PermissionRequestDetailCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 01/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class PermissionRequestDetailCell: UITableViewCell {

    @IBOutlet weak var crossLeaderlabel: UILabel!
    @IBOutlet weak var homeroomLabel: UILabel!
    @IBOutlet weak var permissionRangeDateLabel: UILabel!
    @IBOutlet weak var permissionDescLabel: UILabel!
    @IBOutlet weak var permissionDateLabel: UILabel!
    @IBOutlet weak var permissionTypeLabel: UILabel!
    @IBOutlet weak var permissionReasonView: UIView! {
        didSet {
            permissionReasonView.layer.cornerRadius = permissionReasonView.frame.size.height/2
            permissionReasonView.layer.masksToBounds = true
            permissionReasonView.backgroundColor = ACColor.MAIN
        }
    }
    @IBOutlet weak var studentClassLabel: UILabel!
    @IBOutlet weak var studentNISLabel: UILabel!
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var studentImage: UIImageView! {
        didSet {
            studentImage.layer.cornerRadius = studentImage.frame.size.width / 2
            studentImage.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color: UIColor.gray, shadowRadius: 1.0, shadowOpactiy: 0.5, shadowOffsetWidth: 1, shadowOffsetHeight: 1)
        }
    }
    var permissionObj: PermissionDataModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = permissionObj else { return }
        studentImage.sd_setImage(
            with: URL(string: (obj.child_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        studentNameLabel.text = obj.child_name
        studentNISLabel.text = obj.child_nis
        studentClassLabel.text = obj.school_class
//        permissionTypeLabel.text = obj
        permissionDateLabel.text = "\(getMonth(time: obj.permission_date))"
        permissionDescLabel.text = obj.permission_reason
        homeroomLabel.text = obj.teacher_name
        crossLeaderlabel.text = obj.class_leader
    }
}

extension PermissionRequestDetailCell {
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
        dateFormatterResult.dateFormat = "dd MM yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
