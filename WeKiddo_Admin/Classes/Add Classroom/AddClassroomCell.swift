

//
//  AddClassroomCell.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 07/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

protocol AddClassroomCellDelegate : class{
    func toSelectTeacher()
    func toSelectLeader(schoolId:String)
    func toSelectSecre(schoolId:String)
    func addClassroom(schoolId:String,schoolClass:String,classDesc:String,selectedMajorId:String,selectedLevelId:String,editTeacherId:String,editLeaderId:String,editSecreId:String, schoolLevel:String)
}
class AddClassroomCell: UITableViewCell {

    weak var delegate : AddClassroomCellDelegate?
    var selectedSchoold = ""
    var schools: [String] = []
    var selectedMajorId = ""
    var majors = [String]()
    var selectedLevelId = ""
    var levels = [String]()
    var selectedTeacherId = ""
    var selectedLeaderChildId = ""
    var selectedSecreChildId = ""
    @IBOutlet weak var schoolPicker: ButtonLeftSpace!
    @IBOutlet weak var levelPicker: ButtonLeftSpace!
    @IBOutlet weak var majorPicker: ButtonLeftSpace!
    @IBOutlet weak var classCodeTextField: TextFieldSpace!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var homeroomImg: UIImageView!{
        didSet{
            homeroomImg.layer.cornerRadius = homeroomImg.frame.size.width/2
        }
    }
    @IBOutlet weak var homeroomNameLbl: UILabel!
    @IBOutlet weak var homeroomNUPTKLbl: UILabel!
    @IBOutlet weak var chooseHomeroomBtn: UIButton!
    @IBOutlet weak var classLeaderImg: UIImageView!{
        didSet{
            classLeaderImg.layer.cornerRadius = classLeaderImg.frame.size.width/2
        }
    }
    @IBOutlet weak var classLeaderNameLbl: UILabel!
    @IBOutlet weak var classLeaderNisLbl: UILabel!
    @IBOutlet weak var choosClassLeaderBtn: UIButton!
    @IBOutlet weak var choosClassSecretaryBtn: UIButton!
    @IBOutlet weak var secretaryNameLbl: UILabel!
    @IBOutlet weak var SecretaryNISLbl: UILabel!
    @IBOutlet weak var secretaryImage: UIImageView!{
        didSet{
            secretaryImage.layer.cornerRadius = secretaryImage.frame.size.width/2
        }
    }
    @IBOutlet weak var addBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        schoolPicker.addTarget(self, action: #selector(showSchoolPicker), for: .touchUpInside)
        majorPicker.addTarget(self, action: #selector(showMajorPicker), for: .touchUpInside)
        levelPicker.addTarget(self, action: #selector(showLevelPicker), for: .touchUpInside)
        chooseHomeroomBtn.addTarget(self, action: #selector(toSelectTeacher), for: .touchUpInside)
        choosClassLeaderBtn.addTarget(self, action: #selector(toSelectLeader), for: .touchUpInside)
        choosClassSecretaryBtn.addTarget(self, action: #selector(toSelectSecre), for: .touchUpInside)
        addBtn.addTarget(self, action: #selector(addClassroom), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    var classCode = ""
    var classDesc = ""
    var classObjc : EditClassroomDetailModel?{
        didSet{
            cellDataSet()
        }
    }
    func cellDataSet(){
        guard let obj = classObjc else { return }
        schoolPicker.setTitle(obj.school_name, for: .normal)
        levelPicker.setTitle(obj.school_level, for: .normal)
        majorPicker.setTitle(obj.school_major_id, for: .normal)
        classCodeTextField.text = obj.school_class
        descriptionTextView.text = obj.class_desc
        homeroomNameLbl.text = obj.teacher_name
        self.homeroomImg.sd_setImage(
            with: URL(string: (obj.teacher_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        homeroomNUPTKLbl.text = obj.nuptk
        classLeaderNameLbl.text = obj.leader_name
        classLeaderNisLbl.text = obj.leader_nis
        self.classLeaderImg.sd_setImage(
            with: URL(string: (obj.leader_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        secretaryNameLbl.text = obj.secre_name
        SecretaryNISLbl.text = obj.secre_nis
        self.secretaryImage.sd_setImage(
            with: URL(string: (obj.secre_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
    
    @objc func addClassroom(){
        guard let obj = classObjc else { return }
        self.delegate?.addClassroom(schoolId:selectedSchoold, schoolClass: classCodeTextField.text!,classDesc:descriptionTextView.text!,selectedMajorId:selectedMajorId,selectedLevelId:selectedLevelId,editTeacherId:obj.teacher_id,editLeaderId:obj.leader_id,editSecreId:obj.secre_id, schoolLevel: obj.school_level)
    }
    @objc func toSelectTeacher(){
        self.delegate?.toSelectTeacher()
    }
    @objc func toSelectLeader(){
        self.delegate?.toSelectLeader(schoolId: selectedSchoold)
    }
    @objc func toSelectSecre(){
        self.delegate?.toSelectSecre(schoolId: selectedSchoold)
    }
    @objc func showSchoolPicker() {
        schools.removeAll()
        for value in ACData.LOGINDATA.dashboardSchoolMenu {
            schools.append(value.school_name!)
        }
        ActionSheetStringPicker.show(
            withTitle: "School",
            rows: schools,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let schoolID = ACData.LOGINDATA.dashboardSchoolMenu[indexes].school_id else {
                    return
                }
                guard let yearId = ACData.LOGINDATA.dashboardSchoolMenu[0].year_id else {
                    return
                }
                self.schoolPicker.setTitle(self.schools[indexes], for: .normal)
                self.selectedSchoold = schoolID
                ACData.CLASSROOMADDTEACHERLISTDATA.removeAll()
                ACRequest.POST_ADD_CLASSROOM_GET_LEVEL_MAJOR(userId: ACData.LOGINDATA.userID, schoolId: self.selectedSchoold, yearId: yearId, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (levelMajorData) in
                    ACData.CLASSROOMADDLEVELMAJORDATA = levelMajorData
                }, failCompletion: { (status) in
                    
                })
                ACRequest.POST_ADD_CLASSROOM_TEACHERLIST(userId: ACData.LOGINDATA.userID, schoolId: self.selectedSchoold, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (classroomList) in
                    ACData.CLASSROOMADDTEACHERLISTDATA = classroomList
                }, failCompletion: { (status) in
                    
                })
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    
    @objc func showMajorPicker() {
        majors.removeAll()
        for value in ACData.CLASSROOMADDLEVELMAJORDATA.major {
            majors.append(value.school_major)
        }
        ActionSheetStringPicker.show(
            withTitle: "Major",
            rows: majors,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let majorId = ACData.CLASSROOMADDLEVELMAJORDATA.major[indexes].school_major_id else {
                    return }
                self.majorPicker.setTitle(self.majors[indexes], for: .normal)
                self.selectedMajorId = majorId
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    
    @objc func showLevelPicker() {
        levels.removeAll()
        for value in ACData.CLASSROOMADDLEVELMAJORDATA.level {
            levels.append(value.school_level)
        }
        ActionSheetStringPicker.show(
            withTitle: "Level",
            rows: levels,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let levelId = ACData.CLASSROOMADDLEVELMAJORDATA.level[indexes].school_level_id else {
                    return
                }
                self.levelPicker.setTitle(self.levels[indexes], for: .normal)
                self.selectedLevelId = levelId
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
}
