//
//  ParentProfileSubjectAndClassCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 15/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class ParentProfileSubjectAndClassCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.cornerRadius = 5.0
            bgView.layer.masksToBounds = true
            bgView.layer.borderColor = UIColor.lightGray.cgColor
            bgView.layer.borderWidth = 0.5
        }
    }
    var detailObj: ProfileSubjectClassModel? {
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
        contentLabel.text = "\(obj.subject_name) - \(obj.school_class)"
    }
}
