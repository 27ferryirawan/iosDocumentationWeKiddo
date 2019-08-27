//
//  MoreSchoolViewController.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 03/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class MoreSchoolViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation(){
        self.navigationController?.isNavigationBarHidden = false
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "", isLeftLogoHide: "ic_back_blue", isLeftSecondLogoHide: "")
    }
    func configTable() {
        tableView.register(UINib(nibName: "MoreSchoolCell", bundle: nil), forCellReuseIdentifier: "moreSchoolCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
    }
    
    func viewHeight(dataCount: Int)->CGFloat{
        var viewHeight: CGFloat = 0
        if(dataCount%4 != 0){
            viewHeight = CGFloat((dataCount/4*105+105) + (dataCount/4*10+10) + 272) // sisa tinggi + tinggi 1 cell
            return viewHeight
        }else{
            viewHeight = CGFloat((dataCount/4*105) + (dataCount/4*10) + 272) //15 = sisa tinggi
            return viewHeight
        }
    }
}
extension MoreSchoolViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "moreSchoolCell", for: indexPath) as? MoreSchoolCell)!
        cell.delegate = self
        return cell
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewHeight(dataCount: ACData.LOGININFODATA.count)
    }
}

extension MoreSchoolViewController: SchoolMoreDelegate{
    func gotoSchoolDetail(schoolId : String) {
        ACRequest.GET_SCHOOL_DETAIL(schoolID: schoolId, successCompletion: { (schoolData) in
            ACData.SCHOOLDETAILDATA = schoolData
            SVProgressHUD.dismiss()
            let schoolDetailVc = SchoolDetailViewController()
            self.navigationController?.pushViewController(schoolDetailVc, animated: true)
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
}
