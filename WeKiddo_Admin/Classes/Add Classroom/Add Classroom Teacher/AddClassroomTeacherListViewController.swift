//
//  AddClassroomTeacherListViewController.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 07/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
protocol AddClassroomTeacherListViewControllerDelegate : class{
    func sendData(teacherId:String,teacherName:String,teacherImg:String,teacherNUPTK:String)
}
class AddClassroomTeacherListViewController: UIViewController {

    var teacherId = ""
    var teacherName = ""
    var teacherNUPTK = ""
    var teacherImg = ""
    weak var delegate : AddClassroomTeacherListViewControllerDelegate?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.delegate?.sendData(teacherId: teacherId, teacherName: teacherName, teacherImg: teacherImg, teacherNUPTK: teacherNUPTK)
    }
    func configTable(){
        tableView.register(UINib(nibName: "AddClassroomTeacherListCell", bundle: nil), forCellReuseIdentifier: "addClassroomTeacherListCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Select Homeroom Teacher", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Select Homeroom Teacher", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
}
extension AddClassroomTeacherListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ACData.CLASSROOMADDTEACHERLISTDATA.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "addClassroomTeacherListCell", for: indexPath) as? AddClassroomTeacherListCell)!
        cell.teacherObj = ACData.CLASSROOMADDTEACHERLISTDATA[indexPath.row]
        cell.delegate = self
        return cell
    }
}
extension AddClassroomTeacherListViewController: AddClassroomTeacherListCellDelegate{
    func backToAdd(teacherId: String, teacherName: String, teacherImage: String, teacherNUPTK: String) {
        self.teacherId = teacherId
        self.teacherName = teacherName
        self.teacherNUPTK = teacherNUPTK
        self.teacherImg = teacherImage
        self.dismiss(animated: true, completion: nil)
    }
}
