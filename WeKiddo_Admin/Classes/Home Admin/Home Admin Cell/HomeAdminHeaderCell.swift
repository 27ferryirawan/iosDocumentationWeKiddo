//
//  HomeAdminHeaderCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class HomeAdminHeaderCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!{
        didSet{
            bgView.backgroundColor = ACColor.MAIN
        }
    }
    @IBOutlet weak var contentImage: UIImageView!{
        didSet{
            contentImage.layer.borderColor = ACColor.MAIN.cgColor
            contentImage.layer.borderWidth = 0.5
        }
    }
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var detailObj: DashboardModel? {
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
        guard let obj = detailObj else { return }
        nameLabel.text = obj.home_profile_teacher_name
        schoolLabel.text = obj.home_profile_school_name
        contentImage.sd_setImage(
            with: URL(string: (obj.home_profile_school_logo)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
}
