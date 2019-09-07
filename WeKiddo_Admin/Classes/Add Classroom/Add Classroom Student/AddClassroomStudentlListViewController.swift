//
//  AddClassroomStudentlListViewController.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 07/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol AddClassroomStudentlListViewControllerDelegate:class {
    func backToAddClassroom(childId:String,childName:String,childNIS:String,childImage:String,isLeader:Bool)
}
class AddClassroomStudentlListViewController: UIViewController {

    weak var delegate:AddClassroomStudentlListViewControllerDelegate?
    var isLeader : Bool?
    var studentResult = 0
    var childId = ""
    var childName = ""
    var childNIS = ""
    var childImage = ""
    var schoolId = ""
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        searchBar.delegate = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.delegate?.backToAddClassroom(childId: childId, childName: childName, childNIS: childNIS, childImage: childImage,isLeader: isLeader!)
    }
    func configTable(){
        tableView.register(UINib(nibName: "AddClassroomStudentlCell", bundle: nil), forCellReuseIdentifier: "addClassroomStudentlCell")
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
extension AddClassroomStudentlListViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentResult
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "addClassroomStudentlCell", for: indexPath) as? AddClassroomStudentlCell)!
        cell.studentObj = ACData.CLASSROOMADDSTUDENTSEARCHDATA[indexPath.row]
        cell.delegate = self
        return cell
    }
}
extension AddClassroomStudentlListViewController : AddClassroomStudentlCellDelegate{
    func toAddClassroom(childId: String, childName: String, childImg: String, childNIS: String) {
        self.childId = childId
        self.childName = childName
        self.childImage = childImg
        self.childNIS = childNIS
        self.dismiss(animated: true, completion: nil)
    }
}
extension AddClassroomStudentlListViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let yearId = ACData.LOGINDATA.dashboardSchoolMenu[0].year_id else {
            return
        }
        if searchBar.text!.count > 2 {
            ACData.CLASSROOMADDSTUDENTSEARCHDATA.removeAll()
            studentResult = 0
            ACRequest.POST_ADD_CLASSROOM_STUDENT_SEARCH(userId: ACData.LOGINDATA.userID, schoolId: schoolId, year_id: yearId, keyword: searchBar.text!, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (studentData) in
                ACData.CLASSROOMADDSTUDENTSEARCHDATA = studentData
                self.studentResult = ACData.CLASSROOMADDSTUDENTSEARCHDATA.count
                SVProgressHUD.dismiss()
                self.tableView.reloadData()
            }) { (status) in
                SVProgressHUD.dismiss()
            }
        }
        searchBar.resignFirstResponder()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.studentResult = 0
        tableView.isHidden = false
        tableView.reloadData()
    }
}
