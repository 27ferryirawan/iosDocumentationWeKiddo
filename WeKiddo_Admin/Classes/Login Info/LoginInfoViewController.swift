//
//  LoginInfoViewController.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 27/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
class LoginInfoViewController: UIViewController{
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        tableView.register(UINib(nibName: "RegisterCell", bundle: nil), forCellReuseIdentifier: "registerCell")
        tableView.register(UINib(nibName: "IntorductionCell", bundle: nil), forCellReuseIdentifier: "intorductionCell")
        tableView.register(UINib(nibName: "SchoolCell", bundle: nil), forCellReuseIdentifier: "schoolCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
    }
    func viewHeight(dataCount: Int)->CGFloat {
        var viewHeight: CGFloat = 0
        if(dataCount%4 != 0) {
            viewHeight = CGFloat((dataCount/4*105+105) + (dataCount/4*10+10) + 67) // sisa tinggi + tinggi 1 cell
            return viewHeight
        } else {
            viewHeight = CGFloat((dataCount/4*105) + (dataCount/4*10) + 67) //15 = sisa tinggi
            return viewHeight
        }
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.tableView.frame.origin.y == 0 {
                self.tableView.frame.origin.y -= keyboardSize.height
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.tableView.frame.origin.y != 0 {
            self.tableView.frame.origin.y = 0
        }
    }
}
extension LoginInfoViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = (tableView.dequeueReusableCell(withIdentifier: "intorductionCell", for: indexPath) as? IntorductionCell)!
            return cell
        }
        else if indexPath.row == 1{
            let cell = (tableView.dequeueReusableCell(withIdentifier: "schoolCell", for: indexPath) as? SchoolCell)!
            cell.delegate = self
            return cell
        }
        else{
            let cell = (tableView.dequeueReusableCell(withIdentifier: "registerCell", for: indexPath) as? RegisterCell)!
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 270
        }
        else if indexPath.row == 1{
             return viewHeight(dataCount: 9)
        }
        else{
            return 356
        }
    }
}

extension LoginInfoViewController: SchoolDelegate{
    func goToMore() {
        let moreSchoolVc = MoreSchoolViewController()
        self.navigationController?.pushViewController(moreSchoolVc, animated: true)
    }
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
