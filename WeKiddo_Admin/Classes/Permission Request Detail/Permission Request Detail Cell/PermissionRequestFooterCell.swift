//
//  PermissionRequestFooterCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 01/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol PermissionRequestFooterCellDelegate: class {
    func rejectAction(status: Int, withPermissionID: String)
    func approveAction(status: Int, withPermissionID: String)
}

class PermissionRequestFooterCell: UITableViewCell {

    weak var delegate: PermissionRequestFooterCellDelegate?
    @IBOutlet weak var approveButton: UIButton!{
        didSet{
            approveButton.layer.cornerRadius = 5
            approveButton.clipsToBounds = true
        }
    }
    @IBOutlet weak var rejectButton: UIButton!{
        didSet{
            rejectButton.layer.cornerRadius = 5
            rejectButton.clipsToBounds = true
        }
    }
    @IBOutlet weak var alphaLabel: UILabel!
    @IBOutlet weak var alphaView: UIView! {
        didSet {
            alphaView.layer.cornerRadius = alphaView.frame.size.width / 2
            alphaView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var leaveLabel: UILabel!
    @IBOutlet weak var leaveView: UIView! {
        didSet {
            leaveView.layer.cornerRadius = leaveView.frame.size.width / 2
            leaveView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var sickLabel: UILabel!
    @IBOutlet weak var sickView: UIView! {
        didSet {
            sickView.layer.cornerRadius = sickView.frame.size.width / 2
            sickView.layer.masksToBounds = true
            sickView.backgroundColor = ACColor.MAIN
        }
    }
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color: UIColor.gray, shadowRadius: 1.0, shadowOpactiy: 0.5, shadowOffsetWidth: 1, shadowOffsetHeight: 1)
        }
    }
    var detailObj: PermissionDataModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        rejectButton.addTarget(self, action: #selector(rejectPermission), for: .touchUpInside)
        approveButton.addTarget(self, action: #selector(approvePermission), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        sickLabel.text = obj.count_sick
        leaveLabel.text = obj.count_leave
        alphaLabel.text = obj.count_alpha
    }
    @objc func rejectPermission() {
        updateStatus(statusPermission: 2)
    }
    @objc func approvePermission() {
        updateStatus(statusPermission: 1)
    }
    func updateStatus(statusPermission: Int) {
        guard let obj = detailObj else { return }
        if statusPermission == 1 {
            self.delegate?.approveAction(status: statusPermission, withPermissionID: obj.permission_id)
        } else {
            self.delegate?.rejectAction(status: statusPermission, withPermissionID: obj.permission_id)
        }
    }
}
