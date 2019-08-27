//
//  StudentsNoteViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 10/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class StudentsNoteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var chapterID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        fetchData()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Student Note", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func fetchData() {
        ACRequest.GET_ASSIGNMENT_STUDENT_NOTE(childID: ACData.HOMEDATA.childID, chapterID: chapterID, successCompletion: { (studentNoteData) in
            ACData.STUDENTNOTEDATA = studentNoteData
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "StudentsNoteCell", bundle: nil), forCellReuseIdentifier: "studentNoteCellId")
    }
}

extension StudentsNoteViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 577
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "studentNoteCellId", for: indexPath) as? StudentsNoteCell)!
        cell.noteObj = ACData.STUDENTNOTEDATA
        return cell
    }
}
