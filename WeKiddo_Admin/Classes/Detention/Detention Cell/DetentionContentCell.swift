//
//  DetentionContentCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 09/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

protocol DetentionContentCellDelegate: class {
    func displayReason(withReason: String)
}

class DetentionContentCell: UITableViewCell {

    @IBOutlet weak var teacherName: UILabel!
    @IBOutlet weak var contentButton: UIButton!
    @IBOutlet weak var nisLabel: UILabel! //kelas
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentImage: UIImageView!{
        didSet{
            contentImage.layer.cornerRadius = contentImage.frame.size.width/2
            contentImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color: UIColor.gray, shadowRadius: 1.0, shadowOpactiy: 1, shadowOffsetWidth: Int(0.5), shadowOffsetHeight: 1)
        }
    }
    weak var delegate: DetentionContentCellDelegate?
    var detailObj: DetentionItemsModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        contentButton.addTarget(self, action: #selector(reasonViewClicked), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func reasonViewClicked() {
        guard let obj = detailObj else { return }
        self.delegate?.displayReason(withReason: obj.reason)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        nameLabel.text = obj.child_name
        nisLabel.text = obj.school_class //ganti ke kelas kelas
        teacherName.text = obj.teacher_name
        contentImage.sd_setImage(
            with: URL(string: (obj.child_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
}
