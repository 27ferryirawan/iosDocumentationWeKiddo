//
//  AddLatePaymentStudentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 18/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol AddLatePaymentStudentCellDelegate: class {
    func deleteChildFromArray(atIndex: Int)
}

class AddLatePaymentStudentCell: UITableViewCell {
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var nisLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var bgView: UIView!
    var studentObj: StudentSearchSelected? {
        didSet {
            cellConfig()
        }
    }
    weak var delegate: AddLatePaymentStudentCellDelegate?
    var index = 0
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = studentObj else { return }
        contentImage.sd_setImage(
            with: URL(string: (obj.child_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        nameLabel.text = obj.child_name
        nisLabel.text = obj.child_nis
        classLabel.text = obj.school_class
    }
    @objc func deleteChild() {
        self.delegate?.deleteChildFromArray(atIndex: index)
    }
}
