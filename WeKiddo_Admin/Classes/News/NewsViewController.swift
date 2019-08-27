//
//  NewsViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 03/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var rows = 0
    var totalRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        fetchData()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "News", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "News", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "NewsHeaderCell", bundle: nil), forCellReuseIdentifier: "newsHeaderCell")
        tableView.register(UINib(nibName: "NewsContentCell", bundle: nil), forCellReuseIdentifier: "newsContentCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    func fetchData() {
        ACData.PARENTNEWSCONTENT.removeAll()
        ACRequest.SCHOOL_GET_MORE_NEWS(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
            SVProgressHUD.dismiss()
            ACData.PARENTNEWSCONTENT = jsonDatas
            self.calculateData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    @objc func goToNewsDetail(sender: UIButton) {
        let detail = NewsDetailViewController()
        detail.stringURL = ACData.PARENTNEWSCONTENT[sender.tag-1].news_url
        self.navigationController?.pushViewController(detail, animated: true)
    }
    func calculateData() {
        let totalData = ACData.PARENTNEWSCONTENT.count
        let divResult = totalData/2;
        let modResult = totalData%2;
        totalRow = 0;
        if (modResult != 0) {
            totalRow = divResult + 1;
            rows = totalRow;
        }
        else {
            totalRow = divResult + 1;
            rows = totalRow;
        }
        print("calculated: \(rows) \n data: \(ACData.PARENTNEWSCONTENT.count)")
        tableView.reloadData()
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 240 : 225
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "newsHeaderCell", for: indexPath) as? NewsHeaderCell)!
            cell.config(index: indexPath.row)
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "newsContentCell", for: indexPath) as? NewsContentCell)!
            cell.buttonRight.addTarget(self, action: #selector(goToNewsDetail), for: .touchUpInside)
            cell.buttonLeft.addTarget(self, action: #selector(goToNewsDetail), for: .touchUpInside)

            // Left
            cell.buttonLeft.tag = indexPath.row*2
            cell.imageLeft.sd_setImage(
                with: URL(string: (ACData.PARENTNEWSCONTENT[(indexPath.row*2)-1].news_image)),
                placeholderImage: UIImage(named: "WeKiddoLogo"),
                options: .refreshCached
            )
            cell.labelLeft.text = ACData.PARENTNEWSCONTENT[(indexPath.row*2)-1].news_title
            
            // Right
            if indexPath.row*2+1 >= ACData.PARENTNEWSCONTENT.count {
                cell.viewRight.isHidden = true;
            } else {
                cell.viewRight.isHidden = false
                cell.buttonRight.tag = indexPath.row*2+1
                cell.imageRight.sd_setImage(
                    with: URL(string: (ACData.PARENTNEWSCONTENT[(indexPath.row*2+1)-1].news_image)),
                    placeholderImage: UIImage(named: "WeKiddoLogo"),
                    options: .refreshCached
                )
                cell.labelRight.text = ACData.PARENTNEWSCONTENT[(indexPath.row*2+1)-1].news_title
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = NewsDetailViewController()
        detail.stringURL = ACData.PARENTNEWSCONTENT[indexPath.row].news_url
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
