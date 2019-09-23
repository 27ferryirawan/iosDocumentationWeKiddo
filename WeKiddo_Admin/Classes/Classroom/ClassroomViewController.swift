//
//  ClassroomViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 24/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class ClassroomViewController: UIViewController {

    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var firstSelectedSchool:String?
    var levelCount = 0
    var levelName = [String]()
    var classLevelCount = [Int]()
    var selectedSchool:String?
    var selectedSchoolId:String?
    var selectedSchoolClassId:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        fetchData()
        addBtn.addTarget(self, action: #selector(toAddClass), for: .touchUpInside)
    }
    @objc func toAddClass(){
        let addClassVC = AddClassroomViewController()
        addClassVC.isAddClassroom = true
        self.navigationController?.pushViewController(addClassVC, animated: true)
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Class Room", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Class Room", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "ClassroomHeaderCell", bundle: nil), forCellReuseIdentifier: "classroomHeaderCellID")
        tableView.register(UINib(nibName: "ClassroomContentCell", bundle: nil), forCellReuseIdentifier: "classroomContentCellID")
        tableView.dataSource = self
        tableView.delegate = self
    }
    var schools: [String] = []
    func fetchData(){
        levelName.removeAll()
        schools.removeAll()
        classLevelCount.removeAll()
        levelCount = 0
        guard let schoolID = ACData.LOGINDATA.dashboardSchoolMenu[0].school_id, let yearId = ACData.LOGINDATA.dashboardSchoolMenu[0].year_id else {
            return
        }
        for value in ACData.LOGINDATA.dashboardSchoolMenu {
            schools.append(value.school_name!)
        }
        firstSelectedSchool = schools[0]
        selectedSchool = firstSelectedSchool
        selectedSchoolId = schoolID
        ACRequest.POST_CLASSROOM_DASH(userId: ACData.LOGINDATA.userID, schoolId: schoolID, yearId: yearId, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (classList) in
            ACData.CLASSROOMDASH = classList
            SVProgressHUD.dismiss()
            self.levelCount = ACData.CLASSROOMDASH.classroom_class_list.count
            for indexes in ACData.CLASSROOMDASH.classroom_class_list {
                self.levelName.append(indexes.school_level)
                self.classLevelCount.append(indexes.classroom_classes.count)
            }
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
}
extension ClassroomViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return levelCount + 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        } else {
            return "Level \(levelName[section-1])"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            print(section)
            print("class count\(classLevelCount[section-1])")
            return classLevelCount[section-1]
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 178
        } else {
            return 55
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "classroomHeaderCellID", for: indexPath) as? ClassroomHeaderCell)!
            cell.detailObj = ACData.CLASSROOMDASH
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "classroomContentCellID", for: indexPath) as? ClassroomContentCell)!
            print(indexPath.section-1)
            print(indexPath.row)
            cell.classObjc = ACData.CLASSROOMDASH.classroom_class_list[indexPath.section-1].classroom_classes[indexPath.row]
            cell.delegate = self
            return cell
        }
    }
}
extension ClassroomViewController : ClassroomDelegate, ClassroomContentDelegate{
    func firstPickerClass() -> String {
        return firstSelectedSchool!
    }
    func selectedSchool(schoolName: String, schoolId:String){
        selectedSchool = schoolName
        selectedSchoolId = schoolId
    }
    func refreshData(levelCount: Int, levelName: [String], classLevelCount: [Int]){
        self.levelName.removeAll()
        self.classLevelCount.removeAll()
        self.levelCount = 0
        
        self.levelCount = levelCount
        self.levelName = levelName
        self.classLevelCount = classLevelCount
        self.tableView.reloadData()
    }
    func toDetail(schoolClassId: String){
        let ClassroomDetailVC = ClassroomDetailViewController()
        ClassroomDetailVC.schoolName = selectedSchool!
        ClassroomDetailVC.schoolId = selectedSchoolId!
        ClassroomDetailVC.schoolClassId = schoolClassId
        self.navigationController?.pushViewController(ClassroomDetailVC, animated: true)
    }
}
