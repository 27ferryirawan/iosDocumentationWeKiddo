//
//  SubjectTeacherListCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 13/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol SubjectTeacherListCellDelegate: class {
    func goToSubjectTeacherDetail()
}

class SubjectTeacherListCell: UITableViewCell {

    @IBOutlet weak var contentButton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color:  UIColor.gray, shadowRadius: 3.0, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    weak var delegate: SubjectTeacherListCellDelegate?
    var detailObj: SubjectTeacherChapterTopicListModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        contentButton.addTarget(self, action: #selector(goToDetail), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        titleLabel.text = obj.chapter_name
        contentLabel.text = obj.chapter_desc
    }
    @objc func goToDetail() {
        guard let obj = detailObj else { return }
        ACRequest.POST_SUBJECT_TEACHER_CHAPTER_DETAIL(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, schoolLevelID: ACData.SUBJECTTEACHERCHAPTERLISTDATA.school_level_id, subjectID: ACData.SUBJECTTEACHERCHAPTERLISTDATA.subject_id, chapterID: obj.chapter_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (detailData) in
            SVProgressHUD.dismiss()
            ACData.SUBJECTTEACHERDETAILMODEL = detailData
            self.delegate?.goToSubjectTeacherDetail()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}
