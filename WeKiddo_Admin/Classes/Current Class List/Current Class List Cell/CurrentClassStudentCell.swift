//
//  CurrentClassStudentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 30/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class CurrentClassStudentCell: UITableViewCell {

    @IBOutlet weak var lateLabel: UILabel!
    @IBOutlet weak var nisLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color:  UIColor.gray, shadowRadius: 3.0, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    var studentObj: CurrentClassListSessionStudentModel? {
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
        guard let obj = studentObj else { return }
        nameLabel.text = obj.child_name
        nisLabel.text = obj.child_nis
        contentImage.sd_setImage(
            with: URL(string: (obj.child_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
}
