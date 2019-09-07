//
//  AddClassroomViewController.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 07/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class AddClassroomViewController: UIViewController {

    var teacherId = ""
    var teacherName = ""
    var teacherImage = ""
    var teacherNUPTK = ""
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
        print(teacherName)
        print(teacherNUPTK)
        print(teacherImage)
        print(teacherId)
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
        cell.delegate = self
        return cell
    }
}
extension AddClassroomViewController : AddClassroomCellDelegate, AddClassroomTeacherListViewControllerDelegate{
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
