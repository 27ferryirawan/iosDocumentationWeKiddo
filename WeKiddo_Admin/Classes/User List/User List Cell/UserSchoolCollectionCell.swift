//
//  UserSchoolCollectionCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 06/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class UserSchoolCollectionCell: UICollectionViewCell {

    @IBOutlet weak var nisName: UILabel!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    var isAdmin = Bool()
    var isTeacher = Bool()
    var isHomeroom = Bool()
    var detailObj: UserListMemberModel? {
        didSet {
            cellConfig()
        }
    }
    var detailAdminObj: UserListMemberModel? {
        didSet {
            cellAdminConfig()
        }
    }
    var detailTeacherObj: UserListMemberModel? {
        didSet {
            cellTeacherConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        contentImage.sd_setImage(
            with: URL(string: (obj.teacher_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        studentName.text = obj.teacher_name
        nisName.text = obj.nuptk
    }
    func cellAdminConfig() {
        guard let obj = detailAdminObj else { return }
        contentImage.sd_setImage(
            with: URL(string: (obj.teacher_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        studentName.text = obj.teacher_name
        nisName.text = obj.nuptk
    }
    func cellTeacherConfig() {
        guard let obj = detailTeacherObj else { return }
        contentImage.sd_setImage(
            with: URL(string: (obj.teacher_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        studentName.text = obj.teacher_name
        nisName.text = obj.nuptk
    }
}
