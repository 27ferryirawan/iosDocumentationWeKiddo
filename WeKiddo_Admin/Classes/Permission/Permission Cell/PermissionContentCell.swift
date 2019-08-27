//
//  PermissionContentCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 05/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage

protocol PermissionContentCellDelegate: class {
    func toDetail()
}

class PermissionContentCell: UITableViewCell {
    
    @IBOutlet weak var permissionTypeView: UIView!{
        didSet{
            permissionTypeView.backgroundColor = ACColor.MAIN
            permissionTypeView.layer.cornerRadius = permissionTypeView.frame.size.height/2
            permissionTypeView.clipsToBounds = true
        }
    }
    @IBOutlet weak var permissionTypeLbl: UILabel!
    @IBOutlet weak var permissionButton: UIButton!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var nisLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageStatus: UIImageView!
    @IBOutlet weak var labelDate: UILabel!
    var permissionIndex = ""
    @IBOutlet weak var permissionList: UIView!{
        didSet{
            permissionList.setBorderShadow(color:  UIColor.gray, shadowRadius: 5, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    weak var delegate: PermissionContentCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        permissionButton.addTarget(self, action: #selector(goToPermissionDetail), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configCell(index: Int, isPending:Bool, isApprove:Bool, isReject:Bool) {
        guard let obj = ACData.PERMISSIONDATA else { return }
        if isPending {
            nameLabel.text = obj.permissionPending[index].child_name
            nisLabel.text = obj.permissionPending[index].child_nis
            classLabel.text = obj.permissionPending[index].school_class
            labelDate.text = "\(convertDate(time: obj.permissionPending[index].permission_date))"
            imageStatus.sd_setImage(
                with: URL(string: (obj.permissionPending[index].child_image)),
                placeholderImage: UIImage(named: "WeKiddoLogo"),
                options: .refreshCached
            )
            permissionIndex = obj.permissionPending[index].permission_id
            if obj.permissionPending[index].permission_type == 1{
                permissionTypeLbl.text = "Sick"
            } else if obj.permissionPending[index].permission_type == 2{
                permissionTypeLbl.text = "Holiday"
            }
        } else if isApprove {
            nameLabel.text = obj.permissionApprove[index].child_name
            nisLabel.text = obj.permissionApprove[index].child_nis
            classLabel.text = obj.permissionApprove[index].school_class
            labelDate.text = "\(convertDate(time: obj.permissionApprove[index].permission_date))"
            imageStatus.sd_setImage(
                with: URL(string: (obj.permissionApprove[index].child_image)),
                placeholderImage: UIImage(named: "WeKiddoLogo"),
                options: .refreshCached
            )
            permissionIndex = obj.permissionApprove[index].permission_id
            if obj.permissionApprove[index].permission_type == 1{
                permissionTypeLbl.text = "Sick"
            } else if obj.permissionApprove[index].permission_type == 2{
                permissionTypeLbl.text = "Holiday"
            }
        } else {
            nameLabel.text = obj.permissionReject[index].child_name
            nisLabel.text = obj.permissionReject[index].child_nis
            classLabel.text = obj.permissionReject[index].school_class
            labelDate.text = "\(convertDate(time: obj.permissionReject[index].permission_date))"
            imageStatus.sd_setImage(
                with: URL(string: (obj.permissionReject[index].child_image)),
                placeholderImage: UIImage(named: "WeKiddoLogo"),
                options: .refreshCached
            )
            permissionIndex = obj.permissionReject[index].permission_id
            if obj.permissionReject[index].permission_type == 1{
                permissionTypeLbl.text = "Sick"
            } else if obj.permissionReject[index].permission_type == 2{
                permissionTypeLbl.text = "Holiday"
            }
        }
    }
    @objc func goToPermissionDetail() {
        ACRequest.POST_PERMISSION_DETAIL(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, permissionID: permissionIndex, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (permissionData) in
            SVProgressHUD.dismiss()
            ACData.PERMISSIONDETAILDATA = permissionData
            self.delegate?.toDetail()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
}

extension PermissionContentCell {
    func convertDate(time: String) -> String {
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
        dateFormatterResult.dateFormat = "dd MMM yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
