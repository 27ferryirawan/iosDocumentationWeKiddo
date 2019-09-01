//
//  ExamDetailRemediScheduleCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 19/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol ExamDetailRemediScheduleCellDelegate: class {
    func toEdit(withRemediID: String)
    func toAddStudent(withRemediID: String)
    func didSelectStudent(with obj: StudentsRemedyModel, examID: String)
}

class ExamDetailRemediScheduleCell: UITableViewCell {
    
    @IBOutlet weak var studentCollectionCell: UICollectionView!
    @IBOutlet weak var remediDateLabel: UILabel!
    @IBOutlet weak var remediNumberLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    var indexRow = 0
    var teacherID = ""
    weak var delegate: ExamDetailRemediScheduleCellDelegate?
    var detailObj: ExamDetailRemedyModel? {
        didSet {
            cellConfig()
        }
    }
    @IBOutlet weak var addStudentButton: UIButton! {
        didSet {
            addStudentButton.layer.cornerRadius = 5.0
            addStudentButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var editScoreButton: UIButton! {
        didSet {
            editScoreButton.layer.cornerRadius = 5.0
            editScoreButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var headerView: UIView! {
        didSet {
            headerView.layer.borderColor = UIColor.lightGray.cgColor
            headerView.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.borderColor = UIColor.lightGray.cgColor
            bgView.layer.borderWidth = 1.0
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        editScoreButton.addTarget(self, action: #selector(editScoreAction), for: .touchUpInside)
        addStudentButton.addTarget(self, action: #selector(addStudentAction), for: .touchUpInside)
        studentCollectionCell.register(UINib(nibName: "ExamDetailRemediStudentCell", bundle: nil), forCellWithReuseIdentifier: "examDetailRemediStudentCellID")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        numberLabel.text = "\(self.indexRow)"
        remediNumberLabel.text = "\(obj.title)"
    }
    @objc func editScoreAction() {
        //TODO: Change Value of SchoolID and YearID
        guard let obj = detailObj else { return }
        ACRequest.GET_EXAM_REMEDY_SCORE_LIST(
            userID: ACData.LOGINDATA.userID,
            school_user_id: teacherID,
            schoolID: "SCHOOL10",//ACData.LOGINDATA.dashboardSchoolMenu.last?.school_id ?? "",
            yearID: "YEAR1",//ACData.LOGINDATA.dashboardSchoolMenu.last?.year_id ?? "",
            schoolClassID: ACData.EXAMDETAILDATA.school_class_id,
            examRemedyID: obj.exam_remedy_id,
            tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (datas) in
            SVProgressHUD.dismiss()
            ACData.EXAMREMEDYSCORELISTDATA = datas
            self.delegate?.toEdit(withRemediID: obj.exam_remedy_id)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    @objc func addStudentAction() {
        guard let obj = detailObj else { return }
        self.delegate?.toAddStudent(withRemediID: obj.exam_remedy_id)
    }
}

extension ExamDetailRemediScheduleCell : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let obj = detailObj else { return 0 }
        return obj.students.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "examDetailRemediStudentCellID", for: indexPath) as? ExamDetailRemediStudentCell)!
        guard let obj = detailObj else { return cell }
        cell.detailObj = obj.students[indexPath.row]
        //        cell.configCell(index: indexPath.row)
        //        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let obj = detailObj else { return }
        delegate?.didSelectStudent(with: obj.students[indexPath.row], examID: obj.exam_remedy_id)
    }
}

