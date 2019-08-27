//
//  CompetitionViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 14/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
import ActionSheetPicker_3_0

class CompetitionViewController: UIViewController {

    @IBOutlet weak var competitionPicker: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var categories: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        fetchCategory()
        configPicker()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Competition", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Competition", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "CompetitionCell", bundle: nil), forCellReuseIdentifier: "competitionCell")
    }
    func fetchCategory() {
        ACRequest.GET_COMPETITION_CATEGORY(successCompletion: { (categoryDatas) in
            ACData.COMPETITIONCATEGORYDATA = categoryDatas
            SVProgressHUD.dismiss()
            self.fetchData(index: ACData.COMPETITIONCATEGORYDATA[0].competition_category_id)
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func configPicker() {
        categories.removeAll()
        for value in ACData.COMPETITIONCATEGORYDATA {
            categories.append(value.competition_category_title)
        }

        competitionPicker.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
    }
    func fetchData(index: String) {
        ACRequest.GET_COMPETITION_DATA(competitionCategoryID: index, successCompletion: { (competitionDatas) in
            ACData.COMPETITIONDATA = competitionDatas
            print(competitionDatas)
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    @objc func showPicker() {
        ActionSheetStringPicker.show(
            withTitle: "Select Category",
            rows: categories,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                let categoryID = ACData.COMPETITIONCATEGORYDATA[indexes].competition_category_id
                self.fetchData(index: categoryID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    func fetchDetail(competitionID: String) {
        ACRequest.GET_COMPETITION_DETAIL(competitionID: competitionID, successCompletion: { (competitionDetailData) in
            ACData.COMPETITIONDETAILDATA = competitionDetailData
            SVProgressHUD.dismiss()
            self.goToDetail()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func goToDetail() {
        let competitionDetailVC = CompetitionDetailViewController()
        self.navigationController?.pushViewController(competitionDetailVC, animated: true)
    }
}

extension CompetitionViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ACData.COMPETITIONDATA.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 255
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "competitionCell", for: indexPath) as? CompetitionCell)!
        cell.config(index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fetchDetail(competitionID: ACData.COMPETITIONDATA[indexPath.row].competition_id)
    }
}
