//
//  DetentionViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 07/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class DetentionViewController: UIViewController {

    @IBOutlet weak var grayAreaBtn: UIButton!{
        didSet{
            grayAreaBtn.isHidden = true
            grayAreaBtn.backgroundColor = UIColor(displayP3Red: 102/255, green: 102/255, blue: 102/255, alpha: 0.8)
        }
    }
    @IBOutlet weak var addNewDetentionButton: UIButton!
    @IBOutlet weak var reasonButton: UIButton! {
        didSet {
            reasonButton.layer.cornerRadius = 5.0
            reasonButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var detentionReasonView: UIView! {
        didSet {
            detentionReasonView.setBorderShadow(color: UIColor.gray, shadowRadius: 1.0, shadowOpactiy: 1, shadowOffsetWidth: Int(0.5), shadowOffsetHeight: 1)
        }
    }
    @IBOutlet weak var tableView: UITableView!
    var detentionDatas = 0
    var isReasonViewDisplayed = false
    var reasonString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        fetchData()
        updateView()
        grayAreaBtn.addTarget(self, action: #selector(displayGrayArea), for: .touchUpInside)
    }
    @objc func displayGrayArea(){
        grayAreaBtn.isHidden = true
        detentionReasonView.isHidden = true
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Detention", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Detention", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "DetentionSectionCell", bundle: nil), forCellReuseIdentifier: "detentionSectionCellID")
        tableView.register(UINib(nibName: "DetentionContentCell", bundle: nil), forCellReuseIdentifier: "detentionContentCellID")
        addNewDetentionButton.addTarget(self, action: #selector(addNewDetention), for: .touchUpInside)
        reasonButton.addTarget(self, action: #selector(closeReasonView), for: .touchUpInside)
    }
    func fetchData() {
        ACRequest.POST_DETENTION_LISTS(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (detentionList) in
            ACData.DETENTIONDATA = detentionList
            self.detentionDatas = ACData.DETENTIONDATA.count
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func updateView() {
        if isReasonViewDisplayed {
            grayAreaBtn.isHidden = false
            detentionReasonView.isHidden = false
            reasonLabel.text = reasonString
        } else {
            grayAreaBtn.isHidden = true
            detentionReasonView.isHidden = true
        }
    }
    @objc func closeReasonView() {
        isReasonViewDisplayed = false
        updateView()
    }
    @objc func addNewDetention() {
        let addDetentionVC = AddDetentionViewController()
        self.navigationController?.pushViewController(addDetentionVC, animated: true)
    }
}

extension DetentionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ACData.DETENTIONDATA[section].detention_items.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return ACData.DETENTIONDATA.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 33
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 33))
        bgView.backgroundColor = .white
        let dateLabel = UILabel(frame: CGRect(x: 10, y: 0, width: bgView.frame.size.width - 10, height: 33))
        dateLabel.font = UIFont.systemFont(ofSize: 14.0)
        dateLabel.textColor = .black
        dateLabel.numberOfLines = 0
        dateLabel.text = ACData.DETENTIONDATA[section].dateForHuman
        bgView.addSubview(dateLabel)
        return bgView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "detentionContentCellID", for: indexPath) as? DetentionContentCell)!
        cell.detailObj = ACData.DETENTIONDATA[indexPath.section].detention_items[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension DetentionViewController: DetentionContentCellDelegate {
    func displayReason(withReason: String) {
        reasonString = withReason
        isReasonViewDisplayed = true
        updateView()
    }
}
