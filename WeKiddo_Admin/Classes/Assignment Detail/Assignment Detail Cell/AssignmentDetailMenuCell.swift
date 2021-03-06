//
//  AssignmentDetailMenuCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 05/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol AssignmentDetailMenuCellDelegate: class {
    func toStudentNote()
    func toAttachment()
    func toScore()
}

class AssignmentDetailMenuCell: UITableViewCell {
    
    @IBOutlet weak var collectionMenuCell: UICollectionView!
    var assignmentObj: AssignmentDetailModel?
    weak var delegate: AssignmentDetailMenuCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionMenuCell.register(UINib(nibName: "AssignmentDetailViewCollectionCell", bundle: nil), forCellWithReuseIdentifier: "assignmentDetailCollectionCell")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension AssignmentDetailMenuCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "assignmentDetailCollectionCell", for: indexPath as IndexPath) as! AssignmentDetailViewCollectionCell
        if indexPath.row == 0 {
            cell.cellContent.text = "Attachment"
            cell.cellIcon.image = UIImage(named: "ic_attach")
        } else {
            cell.cellContent.text = "Score"
            cell.cellIcon.image = UIImage(named: "ic_score")
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let obj = assignmentObj else {
            return
        }
        if indexPath.row == 0 {
//            ACData.ATTACHMENTDATA.removeAll()
            // TODO: Change Value of Teacher ID
            guard let teacherID = ACData.ASSIGNMENTTEACHERLISTALL.assignmentTeacherList.first(where: {$0.teacher_name == assignmentObj?.teacher_name ?? ""})?.teacher_id else { return }
            ACRequest.POST_ATTACHMENT_ASSIGNMENT_DETAIL(userId: ACData.LOGINDATA.userID, school_user_id: teacherID, assignID: obj.assignment_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (datas) in
                SVProgressHUD.dismiss()
                ACData.ATTACHMENTDATA = datas
                self.delegate?.toAttachment()
            }) { (message) in
                SVProgressHUD.dismiss()
            }
//            ACRequest.GET_ATTACHMENT(schoolAssignmentID: obj.assignment_id, successCompletion: { (attachmentDatas) in
//                ACData.ATTACHMENTDATA = attachmentDatas
//                SVProgressHUD.dismiss()
//                self.delegate?.toAttachment()
//            }) { (message) in
//                SVProgressHUD.dismiss()
//            }
        } else {
            ACRequest.POST_SCORE_LIST(
                //TODO : Change value of school_user_id, school_id, year_id
                userId: ACData.LOGINDATA.userID,
                school_user_id: ACData.ASSIGNMENTTEACHERLISTALL.assignmentTeacherList.first(where: {$0.teacher_name == obj.teacher_name})?.teacher_id ?? "",
                school_id: ACData.LOGINDATA.dashboardSchoolMenu.last?.school_id ?? "",
                year_id: ACData.LOGINDATA.dashboardSchoolMenu.last?.year_id ?? "",
                assignID: obj.assignment_id,
                classID: obj.school_class_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (scoreDatas) in
                ACData.SCORELISTDATA = scoreDatas
                SVProgressHUD.dismiss()
                self.delegate?.toScore()
            }) { (message) in
                SVProgressHUD.dismiss()
            }
        }
    }
}
