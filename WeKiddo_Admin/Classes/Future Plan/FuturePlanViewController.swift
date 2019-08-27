//
//  FuturePlanViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 14/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class FuturePlanViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var isAcademy = true
    var isCareer = true
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        fetchCareer()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Future Plan", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Future Plan", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "FutureHeaderCell", bundle: nil), forCellReuseIdentifier: "futureHeaderCell")
        tableView.register(UINib(nibName: "FutureContentCell", bundle: nil), forCellReuseIdentifier: "futureContentCell")
    }
    func fetchCareer() {
        ACData.FUTUREPLANCAREERDATA.removeAll()
        ACRequest.GET_FUTURE_PLAN_CAREER(successCompletion: { (futurePlanCareerDatas) in
            ACData.FUTUREPLANCAREERDATA = futurePlanCareerDatas
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func fetchDataAcademy() {
        ACData.FUTUREPLANACADEMYDATA.removeAll()
        ACRequest.GET_FUTURE_PLAN_ACADEMY(successCompletion: { (futurePlanAcademyDatas) in
            ACData.FUTUREPLANACADEMYDATA = futurePlanAcademyDatas
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func fetchDataTalent() {
        ACData.FUTUREPLANTALENTDATA.removeAll()
        ACRequest.GET_FUTURE_PLAN_TALENT(successCompletion: { (futurePlanTalentDatas) in
            ACData.FUTUREPLANTALENTDATA = futurePlanTalentDatas
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    
}
extension FuturePlanViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 280 : 400
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "futureHeaderCell", for: indexPath) as? FutureHeaderCell)!
            cell.isCareer = self.isCareer
            cell.isAcademy = self.isAcademy
            cell.config()
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "futureContentCell", for: indexPath) as? FutureContentCell)!
            cell.isCareer = self.isCareer
            cell.isAcademic = self.isAcademy
            cell.config()
            cell.delegate = self
            return cell
        }
    }
}
extension FuturePlanViewController: FutureHeaderDelegate {
    func getAcademic() {
        isCareer = false
        isAcademy = true
        self.fetchDataAcademy()
    }
    func getTalent() {
        isCareer = false
        isAcademy = false
        self.fetchDataTalent()
    }
    func getCareer() {
        isCareer = true
        isAcademy = false
        self.fetchCareer()
    }
}

extension FuturePlanViewController: FutureContentDelegate {
    func goToCareerDetail() {
        let careerDetailVC = CareerDetailViewController()
        self.navigationController?.pushViewController(careerDetailVC, animated: true)
    }
}
