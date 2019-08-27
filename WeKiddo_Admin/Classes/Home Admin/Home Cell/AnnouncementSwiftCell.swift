//
//  AnnouncementSwiftCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol AnnouncementDelegate {
    func goToAnnouncement()
    func goToExam()
}

class AnnouncementSwiftCell: UITableViewCell {
    var delegate: AnnouncementDelegate? = nil
    var isAnnouncement = false
    @IBOutlet weak var seeMoreAnnouncementBtn: UIButton!{
        didSet {
            seeMoreAnnouncementBtn.layer.cornerRadius = 5
            seeMoreAnnouncementBtn.clipsToBounds = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        seeMoreAnnouncementBtn.addTarget(self, action: #selector(seeAllAnnouncement), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func seeAllAnnouncement() {
        if isAnnouncement {
            self.delegate?.goToAnnouncement()
        } else {
            self.delegate?.goToExam()
        }
    }
}
