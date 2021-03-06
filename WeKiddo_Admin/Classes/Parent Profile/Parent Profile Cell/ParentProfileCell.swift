//
//  ParentProfileCell.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 08/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class ParentProfileCell: UITableViewCell {

    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLable: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var teacherName: UILabel!
    @IBOutlet weak var userNIP: UILabel!
    @IBOutlet weak var profileImage: UIImageView!{
        didSet{
            profileImage.layer.cornerRadius = profileImage.frame.size.width/2
            profileImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var userName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    var detailObj: AdminProfileModel? {
        didSet {
            cellDataSet()
        }
    }
    func cellDataSet() {
        guard let obj = detailObj else {
            return
        }
        self.teacherName.text = ": \(obj.name)"
        self.userNIP.text = ""
        self.userName.text = obj.name
        self.emailLabel.text = ": \(obj.email)"
        self.addressLabel.text = ": \(obj.address)"
        self.positionLabel.text = ": \(obj.admin_pos_name)"
        self.phoneLable.text = ": \(obj.phone)"
        self.genderLabel.text = ": \(obj.gender)"
        self.dobLabel.text = ": \(obj.admin_dob)"
        self.profileImage.sd_setImage(
            with: URL(string: (obj.admin_photo)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
}
