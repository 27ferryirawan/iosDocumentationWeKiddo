//
//  AddStudentCollectionCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 13/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class AddStudentCollectionCell: UICollectionViewCell {

    @IBOutlet weak var contentNIS: UILabel!
    @IBOutlet weak var contentName: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    var objDetail: StudentSearchSelected? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func cellConfig() {
        guard let obj = objDetail else { return }
        contentImage.sd_setImage(
            with: URL(string: (obj.child_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        contentNIS.text = obj.child_nis
        contentName.text = obj.child_name
    }
}
