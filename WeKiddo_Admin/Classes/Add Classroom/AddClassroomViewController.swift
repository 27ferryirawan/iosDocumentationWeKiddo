//
//  AddClassroomViewController.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 07/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
class AddClassroomViewController: UIViewController {

    var school_level_id = ""
    var school_id = ""
    var isAddClassroom : Bool?
    var school_major_id = ""
    var school_class_id = ""
    var teacherId = ""
    var teacherName = ""
    var teacherImage = ""
    var teacherNUPTK = ""
    var leaderChildId = ""
    var leaderChildName = ""
    var leaderChildImage = ""
    var leaderChildNIS = ""
    var secreChildId = ""
    var secreChildName = ""
    var secreChildImage = ""
    var secreChildNIS = ""
    var levelList = [ClassroomLevelModel]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configTable(){
        tableView.register(UINib(nibName: "AddClassroomCell", bundle: nil), forCellReuseIdentifier: "addClassroomCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        if school_id != "" && !isAddClassroom!{
            guard let yearId = ACData.LOGINDATA.dashboardSchoolMenu[0].year_id else {
                return
            }
            ACRequest.POST_ADD_CLASSROOM_GET_LEVEL_MAJOR(userId: ACData.LOGINDATA.userID, schoolId: school_id, yearId: yearId, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (levelMajorData) in
                ACData.CLASSROOMADDLEVELMAJORDATA = levelMajorData
            }, failCompletion: { (status) in
                
            })
            ACRequest.POST_ADD_CLASSROOM_TEACHERLIST(userId: ACData.LOGINDATA.userID, schoolId: school_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (classroomList) in
                ACData.CLASSROOMADDTEACHERLISTDATA = classroomList
            }, failCompletion: { (status) in
                
            })
        }
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Add Classroom", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Add Classroom", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
}
extension AddClassroomViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 923
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "addClassroomCell", for: indexPath) as? AddClassroomCell)!
        if teacherName != "" || teacherNUPTK != "" || teacherImage != "" || teacherId != ""{
            cell.homeroomNameLbl.text = teacherName
            cell.homeroomNUPTKLbl.text = teacherNUPTK
            cell.homeroomImg.sd_setImage(
                with: URL(string: (teacherImage)),
                placeholderImage: UIImage(named: "WeKiddoLogo"),
                options: .refreshCached
            )
            cell.selectedTeacherId = teacherId
        }
        if leaderChildName != "" || leaderChildNIS != "" || leaderChildImage != "" || leaderChildId != ""{
            cell.classLeaderNameLbl.text = leaderChildName
            cell.SecretaryNISLbl.text = leaderChildNIS
            cell.classLeaderImg.sd_setImage(
                with: URL(string: (leaderChildImage)),
                placeholderImage: UIImage(named: "WeKiddoLogo"),
                options: .refreshCached
            )
            cell.selectedLeaderChildId = leaderChildId
        }
        if secreChildName != "" || secreChildNIS != "" || secreChildImage != "" || secreChildId != ""{
            cell.secretaryNameLbl.text = secreChildName
            cell.SecretaryNISLbl.text = secreChildNIS
            cell.secretaryImage.sd_setImage(
                with: URL(string: (secreChildImage)),
                placeholderImage: UIImage(named: "WeKiddoLogo"),
                options: .refreshCached
            )
            cell.selectedSecreChildId = secreChildId
        }
        if !isAddClassroom!{
            cell.classObjc = ACData.CLASSROOMEDITDETAILDATA
        }
        cell.delegate = self
        return cell
    }
}
extension AddClassroomViewController : AddClassroomCellDelegate, AddClassroomTeacherListViewControllerDelegate,AddClassroomStudentlListViewControllerDelegate{
    func addClassroom(schoolId: String, schoolClass: String, classDesc: String, selectedMajorId: String, selectedLevelId: String,editTeacherId:String,editLeaderId:String,editSecreId:String, schoolLevel:String) {
        if isAddClassroom!{
            guard let yearId = ACData.LOGINDATA.dashboardSchoolMenu[0].year_id else {
                return
            }
            ACRequest.POST_ADD_CLASSROOM(user_id: ACData.LOGINDATA.userID, school_id: schoolId, year_id: yearId, school_level_id: selectedLevelId, school_major_id: selectedMajorId, school_class: schoolClass, class_desc: classDesc, teacher_id: teacherId, class_leader: leaderChildId, secretary: secreChildId, school_class_id: "", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
                if status == "success" {
                    ACAlert.show(message: "Successfully Add Classroom")
                    UserDefaults.standard.removeObject(forKey: "AddParentProfileImg")
                } else {
                    ACAlert.show(message: "Failed Add Classroom")
                }
                SVProgressHUD.dismiss()
            }) { (status) in
                SVProgressHUD.dismiss()
            }
        } else {
            guard let yearId = ACData.LOGINDATA.dashboardSchoolMenu[0].year_id else {
                return
            }
            
            ACRequest.POST_ADD_CLASSROOM_GET_LEVEL_MAJOR(userId: ACData.LOGINDATA.userID, schoolId: school_id, yearId: yearId, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (levelMajorData) in
                for a in levelMajorData.level{
                    self.levelList.append(a)
                    print(a)
                }
                for b in self.levelList{
                    if b.school_level == schoolLevel{
                        self.school_level_id = b.school_level_id!
                    }
                }
            }, failCompletion: { (status) in
                
            })
            ACRequest.POST_ADD_CLASSROOM(user_id: ACData.LOGINDATA.userID, school_id: school_id, year_id: yearId, school_level_id: school_level_id, school_major_id: school_major_id, school_class: schoolClass, class_desc: classDesc, teacher_id: editTeacherId, class_leader: editLeaderId, secretary: editSecreId, school_class_id: school_class_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
                if status == "success" {
                    ACAlert.show(message: "Successfully Edit Classroom")
                    UserDefaults.standard.removeObject(forKey: "AddParentProfileImg")
                } else {
                    ACAlert.show(message: "Failed Edit Classroom")
                }
                SVProgressHUD.dismiss()
            }) { (status) in
                SVProgressHUD.dismiss()
            }
        }
    }
    func backToAddClassroom(childId: String, childName: String, childNIS: String, childImage: String,isLeader:Bool) {
        if isLeader{
            self.leaderChildId = childId
            self.leaderChildName = childName
            self.leaderChildNIS = childNIS
            self.leaderChildImage = childImage
        } else {
            self.secreChildId = childId
            self.secreChildName = childName
            self.secreChildNIS = childNIS
            self.secreChildImage = childImage
        }
        tableView.reloadData()
    }
    func toSelectSecre(schoolId: String) {
        let addClassroomStudentVC = AddClassroomStudentlListViewController()
        addClassroomStudentVC.schoolId = schoolId
        addClassroomStudentVC.isLeader = false
        addClassroomStudentVC.delegate = self
        self.present(addClassroomStudentVC, animated: true, completion: nil)
    }
    
    func toSelectLeader(schoolId: String) {
        let addClassroomStudentVC = AddClassroomStudentlListViewController()
        addClassroomStudentVC.schoolId = schoolId
        addClassroomStudentVC.isLeader = true
        addClassroomStudentVC.delegate = self
        self.present(addClassroomStudentVC, animated: true, completion: nil)
    }
    
    func sendData(teacherId: String, teacherName: String, teacherImg: String, teacherNUPTK: String) {
        self.teacherId = teacherId
        self.teacherName = teacherName
        self.teacherImage = teacherImg
        self.teacherNUPTK = teacherNUPTK
        tableView.reloadData()
    }
    func toSelectTeacher() {
        let addClassTeachSelectVC = AddClassroomTeacherListViewController()
        addClassTeachSelectVC.delegate = self
        self.present(addClassTeachSelectVC, animated: true, completion: nil)
    }
}
