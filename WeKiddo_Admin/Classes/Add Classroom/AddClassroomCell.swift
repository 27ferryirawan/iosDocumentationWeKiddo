

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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func toSelectTeacher(){
        self.delegate?.toSelectTeacher()
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
//                if ACData.CLASSROOMADDLEVELMAJORDATA.level.isEmpty == false{
//                   ACData.CLASSROOMADDLEVELMAJORDATA.level.removeAll()
//                }
//                if !ACData.CLASSROOMADDLEVELMAJORDATA.major.isEmpty == false{
//                    ACData.CLASSROOMADDLEVELMAJORDATA.major.removeAll()
//                }
//                if !ACData.CLASSROOMADDTEACHERLISTDATA.isEmpty == false{
//                    ACData.CLASSROOMADDTEACHERLISTDATA.removeAll()
//                }
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
