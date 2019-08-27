//
//  AnnouncementAddNewButtonCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 17/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol AnnouncementAddNewButtonCellDelegate: class {
    func toAddAnnouncementPage()
}

class AnnouncementAddNewButtonCell: UITableViewCell {

    @IBOutlet weak var addAnnouncementButton: UIButton!
    weak var delegate: AnnouncementAddNewButtonCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        addAnnouncementButton.addTarget(self, action: #selector(toAddAnnouncement), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func toAddAnnouncement() {
        ACRequest.GET_ANNOUNCEMENT_LEVEL_DATA(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, accessToken: ACData.LOGINDATA.accessToken, successCompletion: { (levelDatas) in
            SVProgressHUD.dismiss()
            ACData.ANNOUNCEMENTLEVELLISTDATA = levelDatas
            self.delegate?.toAddAnnouncementPage()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}
