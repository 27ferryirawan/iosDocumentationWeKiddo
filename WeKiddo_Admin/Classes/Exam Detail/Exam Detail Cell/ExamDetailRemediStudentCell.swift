//
//  ExamDetailRemediStudentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 24/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class ExamDetailRemediStudentCell: UICollectionViewCell {

    @IBOutlet weak var contentNIS: UILabel!
    @IBOutlet weak var contentName: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    var detailObj: StudentsRemedyModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        contentImage.sd_setImage(
            with: URL(string: obj.child_image),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        contentName.text = obj.child_name
        contentNIS.text = obj.child_nis
    }
}
