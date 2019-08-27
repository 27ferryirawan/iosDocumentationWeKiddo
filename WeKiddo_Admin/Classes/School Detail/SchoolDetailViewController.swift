//
//  SchoolDetailViewController.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 29/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class SchoolDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        configNavigation()
//        fetchData()
    }
    /*
    func fetchData(){
        ACRequest.GET_SCHOOL_DETAIL(schoolID: "SCHOOL1", successCompletion: { (schoolData) in
            ACData.SCHOOLDETAILDATA = schoolData
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    */
    func configTable(){
        tableView.register(UINib(nibName: "SchoolHeaderCell", bundle: nil), forCellReuseIdentifier: "schoolHeaderCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    func configNavigation(){
        self.navigationController?.isNavigationBarHidden = false
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "", isLeftLogoHide: "ic_back_blue", isLeftSecondLogoHide: "")
    }
}
extension SchoolDetailViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "schoolHeaderCell", for: indexPath) as? SchoolHeaderCell)!
        cell.detailObj = ACData.SCHOOLDETAILDATA
        cell.delegate = self
        return cell
    }
}
extension SchoolDetailViewController: SchoolHeaderDelegate {
    func goToVideoPlayer(videoID: String) {
        let videoPlayerVC = VideoPlayerViewController()
        videoPlayerVC.videoID = videoID
        self.navigationController?.pushViewController(videoPlayerVC, animated: true)
    }
}
