//
//  SpecialAttentionByClassDetailHeaderCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 05/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class SpecialAttentionByClassDetailHeaderCell: UITableViewCell {

    @IBOutlet weak var sectionView: UIView! {
        didSet {
            sectionView.setBorderShadow(color: UIColor.lightGray, shadowRadius: 1.0, shadowOpactiy: 0.5, shadowOffsetWidth: 1, shadowOffsetHeight: 1)
            sectionView.backgroundColor = ACColor.MAIN
        }
    }
    @IBOutlet weak var studentScoreLabel: UILabel!
    @IBOutlet weak var scoreView: UIView! {
        didSet {
            scoreView.layer.cornerRadius = scoreView.frame.size.width / 2
            scoreView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var studentSubject: UILabel!
    @IBOutlet weak var studentClass: UILabel!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentImage: UIImageView!
    @IBOutlet weak var headerView: UIView! {
        didSet {
            headerView.setBorderShadow(color: UIColor.lightGray, shadowRadius: 1.0, shadowOpactiy: 0.5, shadowOffsetWidth: 1, shadowOffsetHeight: 1)
        }
    }
    var detailObj: SpecialAttentionByClassDetailModel? {
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
        studentImage.sd_setImage(
            with: URL(string: (obj.child_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        studentName.text = obj.child_name
        studentClass.text = obj.child_nis
        studentSubject.text = "Subject"
        studentScoreLabel.text = "\(obj.subject_count)"
    }
}
