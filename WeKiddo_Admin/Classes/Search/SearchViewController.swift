//
//  SearchViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 12/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var subjectId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Search", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "SearchSectionCell", bundle: nil), forCellReuseIdentifier: "searchSectionCellID")
        tableView.register(UINib(nibName: "SearchAssignmentCell", bundle: nil), forCellReuseIdentifier: "searchAssignmentCellID")
        tableView.register(UINib(nibName: "SearchSessionCell", bundle: nil), forCellReuseIdentifier: "searchSessionCellID")
        tableView.register(UINib(nibName: "SearchNoDataCell", bundle: nil), forCellReuseIdentifier: "searchNoDataCellID")
//        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 3 {
            ACRequest.GET_SUBJECT_SEARCH(keyword: searchText, childID: ACData.HOMEDATA.childID, subjectID: subjectId, successCompletion: { (searchData) in
                ACData.SEARCHDATA = searchData
                SVProgressHUD.dismiss()
                self.tableView.reloadData()
                searchBar.resignFirstResponder()
            }) { (message) in
                SVProgressHUD.dismiss()
            }
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let assignmentResult = ACData.SEARCHDATA else {
            return 0
        }
        if assignmentResult.upcoming_assignments.count != 0 && assignmentResult.upcoming_sessions.count != 0 {
            return 2 + assignmentResult.upcoming_assignments.count + assignmentResult.upcoming_sessions.count
        } else if assignmentResult.upcoming_assignments.count != 0 && assignmentResult.upcoming_sessions.count == 0 {
            return 1 + assignmentResult.upcoming_assignments.count
        } else if assignmentResult.upcoming_assignments.count == 0 && assignmentResult.upcoming_sessions.count != 0 {
            return 1 + assignmentResult.upcoming_sessions.count
        } else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if ACData.SEARCHDATA.upcoming_assignments.count != 0 && ACData.SEARCHDATA.upcoming_sessions.count != 0 {
            if indexPath.row == 0 {
                return 33
            } else if indexPath.row > 0 && indexPath.row < 1 + ACData.SEARCHDATA.upcoming_assignments.count {
                return 66
            } else if indexPath.row == 1 + ACData.SEARCHDATA.upcoming_assignments.count {
                return 33
            } else {
                return 66
            }
        } else if ACData.SEARCHDATA.upcoming_assignments.count != 0 && ACData.SEARCHDATA.upcoming_sessions.count == 0 {
            if indexPath.row == 0 {
                return 33
            } else {
                return 66
            }
        } else if ACData.SEARCHDATA.upcoming_assignments.count == 0 && ACData.SEARCHDATA.upcoming_sessions.count != 0 {
            if indexPath.row == 0 {
                return 33
            } else {
                return 66
            }
        } else {
            return 396
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if ACData.SEARCHDATA.upcoming_assignments.count != 0 && ACData.SEARCHDATA.upcoming_sessions.count != 0 {
            if indexPath.row == 0 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "searchSectionCellID", for: indexPath) as? SearchSectionCell)!
                cell.config(isAssignment: true)
                return cell
            } else if indexPath.row > 0 && indexPath.row < 1 + ACData.SEARCHDATA.upcoming_assignments.count {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "searchSessionCellID", for: indexPath) as? SearchSessionCell)!
                cell.assignmentObjc = ACData.SEARCHDATA.upcoming_assignments[indexPath.row-1]
                cell.delegate = self
                return cell
            } else if indexPath.row == 1 + ACData.SEARCHDATA.upcoming_assignments.count {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "searchSectionCellID", for: indexPath) as? SearchSectionCell)!
                cell.config(isAssignment: false)
                return cell
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "searchAssignmentCellID", for: indexPath) as? SearchAssignmentCell)!
                
                return cell
            }
        } else if ACData.SEARCHDATA.upcoming_assignments.count != 0 && ACData.SEARCHDATA.upcoming_sessions.count == 0 {
            if indexPath.row == 0 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "searchSectionCellID", for: indexPath) as? SearchSectionCell)!
                cell.config(isAssignment: true)
                return cell
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "searchSessionCellID", for: indexPath) as? SearchSessionCell)!
                cell.assignmentObjc = ACData.SEARCHDATA.upcoming_assignments[indexPath.row-1]
                cell.delegate = self
                return cell
            }
        } else if ACData.SEARCHDATA.upcoming_assignments.count == 0 && ACData.SEARCHDATA.upcoming_sessions.count != 0 {
            if indexPath.row == 0 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "searchSectionCellID", for: indexPath) as? SearchSectionCell)!
                cell.config(isAssignment: false)
                return cell
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "searchAssignmentCellID", for: indexPath) as? SearchAssignmentCell)!
                
                return cell
            }
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "searchNoDataCellID", for: indexPath) as? SearchNoDataCell)!
            
            return cell
        }
    }
}

extension SearchViewController: SearchAssignmentCellDelegate {
    func goToAssignmentDetailPage() {
        let assignmentDetailvc = AssignmentDetailViewController()
        self.navigationController?.pushViewController(assignmentDetailvc, animated: true)
    }
}
