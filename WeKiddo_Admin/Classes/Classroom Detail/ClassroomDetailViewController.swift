//
//  ClassroomDetailViewController.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 03/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class ClassroomDetailViewController: UIViewController {

    var childCount = 0
    @IBOutlet weak var homeroomProfileImage: UIImageView!{
        didSet{
            homeroomProfileImage.layer.cornerRadius = homeroomProfileImage.frame.size.width/2
        }
    }
    @IBOutlet weak var leaderProfileImage: UIImageView!{
        didSet{
            leaderProfileImage.layer.cornerRadius = homeroomProfileImage.frame.size.width/2
        }
    }
    @IBOutlet weak var secreProfileImage: UIImageView!{
        didSet{
            secreProfileImage.layer.cornerRadius = homeroomProfileImage.frame.size.width/2
        }
    }
    var school_level = ""
    @IBOutlet weak var homeroomNameLbl: UILabel!
    @IBOutlet weak var homeroomNIKLbl: UILabel!
    @IBOutlet weak var leaderNameLbl: UILabel!
    @IBOutlet weak var leaderNISLbl: UILabel!
    @IBOutlet weak var secreNameLbl: UILabel!
    @IBOutlet weak var secreNISLbl: UILabel!
    @IBOutlet weak var classNameLbl: UILabel!
    @IBOutlet weak var classSchoolYearLbl: UILabel!
    @IBOutlet weak var addStudentBtn: UIButton!
    @IBOutlet weak var editClassBtn: UIButton!
    var schoolName:String?
    var schoolId:String?
    var schoolClassId:String?
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.layer.cornerRadius = 10
            collectionView.layer.borderWidth = 1
            collectionView.layer.borderColor = UIColor(hex: "#D3D3D3").cgColor
            collectionView.clipsToBounds = true
        }
    }
    @IBOutlet weak var classPosView: UIView!{
        didSet{
            classPosView.layer.cornerRadius = 10
            classPosView.layer.borderWidth = 1
            classPosView.layer.borderColor = UIColor(hex: "#D3D3D3").cgColor
            classPosView.clipsToBounds = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configCollection()
        populateData()
        addStudentBtn.addTarget(self, action: #selector(toAddStudent), for: .touchUpInside)
        editClassBtn.addTarget(self, action: #selector(toEditClass), for: .touchUpInside)
    }
    @objc func toAddStudent(){
        let addStudentVC = AddStudentViewController()
        addStudentVC.schoolClassId = schoolClassId
        addStudentVC.schoolId = self.schoolId
        addStudentVC.schoolName = self.schoolName
        self.navigationController?.pushViewController(addStudentVC, animated: true)
    }
    @objc func toEditClass(){
        guard let yearId = ACData.LOGINDATA.dashboardSchoolMenu[0].year_id else {
            return
        }
        guard let obj = ACData.CLASSROOMDETAILDATA else { return }
        ACRequest.POST_GET_EDIT_CLASSROOM_DETAIL(userId: ACData.LOGINDATA.userID, schoolId: schoolId!, yearId: yearId, school_class_id: schoolClassId!, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (classroomData) in
            ACData.CLASSROOMEDITDETAILDATA = classroomData
            let addClassVC = AddClassroomViewController()
            addClassVC.school_major_id = obj.school_major_id
            addClassVC.school_class_id = self.schoolClassId!
            addClassVC.school_id = self.schoolId!
            addClassVC.isAddClassroom = false
            addClassVC.selectedSchoolLevel = self.school_level
            SVProgressHUD.dismiss()
            self.navigationController?.pushViewController(addClassVC, animated: true)
        }) { (status) in
            SVProgressHUD.dismiss()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    func populateData(){
        guard let obj = ACData.CLASSROOMDETAILDATA else { return }
        homeroomProfileImage.sd_setImage(
            with: URL(string: (obj.teacher_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        leaderProfileImage.sd_setImage(
            with: URL(string: (obj.leader_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        secreProfileImage.sd_setImage(
            with: URL(string: (obj.secre_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        homeroomNameLbl.text = obj.teacher_name
        homeroomNIKLbl.text = obj.nuptk
        leaderNameLbl.text = obj.leader_name
        leaderNISLbl.text = obj.leader_nis
        secreNameLbl.text = obj.secre_name
        secreNISLbl.text = obj.secre_nis
        classNameLbl.text = obj.school_class
        classSchoolYearLbl.text = "Kelas \(obj.school_class) \(schoolName!) Tahun \(obj.year_desc)"
        school_level = obj.school_level
    }
    
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Class Room", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Class Room", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configCollection(){
        collectionView.register(UINib(nibName: "ClassroomChildCell", bundle: nil), forCellWithReuseIdentifier: "classroomChildCell")
        childCount = ACData.CLASSROOMDETAILDATA.list_student.count
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}
extension ClassroomDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "classroomChildCell", for: indexPath) as? ClassroomChildCell)!
        cell.userName.text = "\(ACData.CLASSROOMDETAILDATA.list_student[indexPath.row].child_name)"
        cell.userImage.layer.cornerRadius = cell.userImage.frame.width / 2
        cell.userImage.sd_setImage(
            with: URL(string: (ACData.CLASSROOMDETAILDATA.list_student[indexPath.row].child_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let yearId = ACData.LOGINDATA.dashboardSchoolMenu[0].year_id else {
            return
        }
        ACRequest.POST_CLASSROOM_STUDENT_DETAIL(userId: ACData.LOGINDATA.userID, school_id: schoolId!, yearId: yearId, child_id: ACData.CLASSROOMDETAILDATA.list_student[indexPath.row].child_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (studentData) in
            ACData.CLASSROOMSTUDENTDETAILDATA = studentData
            SVProgressHUD.dismiss()
            let StudentDetailVC = StudentDetailViewController()
            StudentDetailVC.schoolId = self.schoolId
            self.navigationController?.pushViewController(StudentDetailVC, animated: true)
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
}
