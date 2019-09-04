//
//  ClassroomDetailViewController.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 03/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

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
    @IBOutlet weak var homeroomNameLbl: UILabel!
    @IBOutlet weak var homeroomNIKLbl: UILabel!
    @IBOutlet weak var leaderNameLbl: UILabel!
    @IBOutlet weak var leaderNISLbl: UILabel!
    @IBOutlet weak var secreNameLbl: UILabel!
    @IBOutlet weak var secreNISLbl: UILabel!
    @IBOutlet weak var classNameLbl: UILabel!
    @IBOutlet weak var classSchoolYearLbl: UILabel!
    var schoolName:String?
    
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
        print("NIS \(obj.secre_nis)")
        print("NUPTK \(obj.nuptk)")
        secreNISLbl.text = obj.secre_nis
        classNameLbl.text = obj.school_class
        classSchoolYearLbl.text = "Kelas \(obj.school_class) \(schoolName!) Tahun \(obj.year_desc)"
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
    
    
}
