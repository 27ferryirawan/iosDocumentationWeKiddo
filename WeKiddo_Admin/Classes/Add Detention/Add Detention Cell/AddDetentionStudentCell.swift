//
//  AddDetentionStudentCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 09/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

protocol AddDetentionStudentCellDelegate: class {
    func deleteChildFromArray(atIndex: Int)
}

class AddDetentionStudentCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var studentClass: UILabel!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentImage: UIImageView!
    var studentObj: StudentSearchSelected? {
        didSet {
            cellConfig()
        }
    }
    weak var delegate: AddDetentionStudentCellDelegate?
    var index = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        deleteButton.addTarget(self, action: #selector(deleteChild), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = studentObj else { return }
        studentImage.sd_setImage(
            with: URL(string: (obj.child_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        studentName.text = obj.child_name
        studentClass.text = obj.school_class
    }
    @objc func deleteChild() {
        self.delegate?.deleteChildFromArray(atIndex: index)
    }
}
