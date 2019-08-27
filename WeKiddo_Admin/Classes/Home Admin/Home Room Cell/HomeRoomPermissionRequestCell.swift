//
//  HomeRoomPermissionRequestCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD

protocol HomeRoomPermissionRequestCellDelegate: class {
    func toDetailPermission()
}

class HomeRoomPermissionRequestCell: UITableViewCell {

    @IBOutlet weak var contentButton: UIButton!
    @IBOutlet weak var permissionView: UIView!{
        didSet{
            permissionView.layer.cornerRadius = permissionView.frame.size.height/2
        }
    }
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var permissionLabel: UILabel!
    @IBOutlet weak var nisLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color:  UIColor.gray, shadowRadius: 3.0, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    var permissionObj: DashboardModelPermissionRequest? {
        didSet {
            cellConfig()
        }
    }
    weak var delegate: HomeRoomPermissionRequestCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        contentButton.addTarget(self, action: #selector(fetchDetail), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = permissionObj else { return }
        nameLabel.text = obj.child_name
        nisLabel.text = obj.child_nis
        dateLabel.text = getMonth(time: obj.permission_date)
        if obj.permission_type == "1" {
            permissionLabel.text = "Sick"
        } else {
            permissionLabel.text = "Holiday"
        }
        contentImage.sd_setImage(
            with: URL(string: (obj.child_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
    @objc func fetchDetail() {
        guard let obj = permissionObj else { return }
        ACRequest.POST_PERMISSION_DETAIL(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, permissionID: obj.permission_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (permissionData) in
            SVProgressHUD.dismiss()
            ACData.PERMISSIONDETAILDATA = permissionData
            self.delegate?.toDetailPermission()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
}

extension HomeRoomPermissionRequestCell {
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
        dateFormatterResult.dateFormat = "yyyy-MM-dd"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
