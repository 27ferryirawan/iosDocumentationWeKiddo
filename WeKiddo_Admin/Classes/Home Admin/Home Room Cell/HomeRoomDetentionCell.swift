//
//  HomeRoomDetentionCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

protocol HomeRoomDetentionCellDelegate: class {
    func showDetentionReason(withReason: String)
}

class HomeRoomDetentionCell: UITableViewCell {

    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var nisLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color:  UIColor.gray, shadowRadius: 3.0, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    weak var delegate: HomeRoomDetentionCellDelegate?
    var detentObj: DashboardModelDetention? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        statusButton.addTarget(self, action: #selector(showStatus), for: .touchUpInside)    
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detentObj else { return }
        contentImage.sd_setImage(
            with: URL(string: (obj.child_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        nameLabel.text = obj.child_name
        nisLabel.text = obj.school_class
        teacherLabel.text = obj.teacher_name
    }
    @objc func showStatus() {
        print("asd")
        guard let obj = detentObj else { return }
        self.delegate?.showDetentionReason(withReason: obj.reason)
    }
}
