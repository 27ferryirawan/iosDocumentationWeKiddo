//
//  ScoreViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 11/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class ScoreViewController: UIViewController {

    @IBOutlet weak var examLabel: UILabel!
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var homeworkLabel: UILabel!
    @IBOutlet weak var closeViewScoreButton: UIButton!
    @IBOutlet weak var viewScore: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewNewSelected: UIView!
    @IBOutlet weak var viewSummarySelected: UIView!
    var isNew: Bool = true
    let candidates = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
    let ratings = [33.0, 20.0, 13.0, 9.0, 8.0, 6.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        fetchData()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Score", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Score", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "DismissCell", bundle: nil), forCellReuseIdentifier: "dismissCell")
        tableView.register(UINib(nibName: "ScoreNewCell", bundle: nil), forCellReuseIdentifier: "scoreNewCell")
        tableView.register(UINib(nibName: "ScoreSummaryCell", bundle: nil), forCellReuseIdentifier: "scoreSummaryCell")
        tableView.dataSource = self
        tableView.delegate = self
        isNew = true
        viewScore.isHidden = true
        viewScore.layer.borderColor = UIColor.lightGray.cgColor
        viewScore.layer.borderWidth = 1.0
        viewScore.layer.cornerRadius = 5.0
        viewScore.layer.masksToBounds = true
    }
    func fetchData() {
        ACData.SCOREDATA.removeAll()
        ACRequest.GET_SCORE(childID: ACData.HOMEDATA.childID, successCompletion: { (scoreData) in
            ACData.SCOREDATA = scoreData
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func fetchSummary() {
        ACData.SCORESUMMARYDATA.removeAll()
        ACRequest.GET_SCORE_SUMMARY(childID: ACData.HOMEDATA.childID, successCompletion: { (scoreData) in
            ACData.SCORESUMMARYDATA = scoreData
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    @IBAction func newSelected(_ sender: Any) {
        viewNewSelected.backgroundColor = ACColor.MAIN
        viewSummarySelected.backgroundColor = .clear
        isNew = true
        fetchData()
    }
    @IBAction func summarySelected(_ sender: Any) {
        viewNewSelected.backgroundColor = .clear
        viewSummarySelected.backgroundColor = ACColor.MAIN
        isNew = false
        fetchSummary()
    }
    func archieveData(subjectID: String, scoreTypeID: String, childID:String) {
        ACRequest.POST_DELETE_SCORE(subjectID: subjectID, scoreTypeID: scoreTypeID, childID: childID, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            self.fetchData()
        }) { (status) in
            SVProgressHUD.dismiss()
        }
    }
    @IBAction func closeScoreView(_ sender: UIButton) {
        viewScore.isHidden = true
    }
    func displayScore() {
        viewScore.isHidden = false
        // TODO: Fetch data score
    }
}

extension ScoreViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isNew {
            return ACData.SCOREDATA.count + 1
        } else {
            return ACData.SCORESUMMARYDATA.count
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if isNew {
            return true
        } else {
            return false
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            if isNew && indexPath.row != 0 {
                archieveData(subjectID: ACData.SCOREDATA[indexPath.row - 1].subject_id, scoreTypeID: ACData.SCOREDATA[indexPath.row - 1].score_type_id, childID:ACData.HOMEDATA.childID)
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isNew && indexPath.row == 0 {
            return 37
        } else if isNew && indexPath.row != 0 {
            return 250
        } else {
          return  510
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isNew {
            if indexPath.row == 0 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "dismissCell", for: indexPath) as? DismissCell)!
                
                return cell
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "scoreNewCell", for: indexPath) as? ScoreNewCell)!
                cell.scoreObj = ACData.SCOREDATA[indexPath.row - 1]
                return cell
            }
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "scoreSummaryCell", for: indexPath) as? ScoreSummaryCell)!
            cell.dataObj = ACData.SCORESUMMARYDATA[indexPath.row]
            cell.delegate = self
            return cell
        }
    }
}

extension ScoreViewController: ScoreSummaryDelegate {
    func displayScoreView() {
        self.displayScore()
    }
}
