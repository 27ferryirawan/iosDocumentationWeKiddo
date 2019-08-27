//
//  StudentCollectionViewCell.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 12/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
class StudentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var studentStatusImg: UIImageView!{
        didSet{
            studentStatusImg.isHidden = true
        }
    }
    @IBOutlet weak var studentProfileImage: UIImageView!
    @IBOutlet weak var studentNameLbl: UILabel!
    @IBOutlet weak var studentNISLbl: UILabel!
    var childObjc: TeacherOnDutyClassInfoModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func cellConfig() {
        guard let obj = childObjc else { return }
        studentNameLbl.text = obj.child_name
        studentNISLbl.text = "NIS \(obj.child_nis)"
        studentProfileImage.sd_setImage(
            with: URL(string: (obj.child_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        // 1 no img
        // 2 silang
        // 3 seru
        // 4 centang
        if obj.status == 1{
            studentStatusImg.isHidden = true
        } else if obj.status == 2{
            studentStatusImg.isHidden = false
            studentStatusImg.image = UIImage(named: "icon_red_cross")
        } else if obj.status == 3{
            studentStatusImg.isHidden = false
            studentStatusImg.image = UIImage(named: "ic_warning_blue")
        } else if obj.status == 4{
            studentStatusImg.isHidden = false
            studentStatusImg.image = UIImage(named: "ic_accept_green")
        }
    }

}
