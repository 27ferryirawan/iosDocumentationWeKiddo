//
//  CalendarViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 11/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class CalendarViewController: UIViewController, CalenderDelegate {
    
    @IBOutlet weak var agendaTableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var agendaButton: UIButton!{
        didSet{
            agendaButton.backgroundColor = UIColor.white
            agendaButton.setTitleColor(ACColor.MAIN, for: .normal)
            agendaButton.layer.borderColor = ACColor.MAIN.cgColor
            agendaButton.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var monthlyButton: UIButton!{
        didSet{
            monthlyButton.backgroundColor = ACColor.MAIN
            monthlyButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
    lazy var  calenderView: CalenderView = {
        let calenderView = CalenderView(theme: MyTheme.light)
        calenderView.translatesAutoresizingMaskIntoConstraints=false
        return calenderView
    }()
    var currentDate = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentDate()
        getData()
        configNavigation()
        configView()
        configTable()
    }
    func getCurrentDate() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        currentDate = result
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Calendar", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Calendar", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "TopicCell", bundle: nil), forCellReuseIdentifier: "topicCell")
        tableView.register(UINib(nibName: "ScheduleCell", bundle: nil), forCellReuseIdentifier: "scheduleCell")
         tableView.register(UINib(nibName: "CalendarSectionCell", bundle: nil), forCellReuseIdentifier: "calendarSectionCell")
        tableView.register(UINib(nibName: "AddNewEventCell", bundle: nil), forCellReuseIdentifier: "addNewEventCell")
        agendaTableView.register(UINib(nibName: "AddNewEventCell", bundle: nil), forCellReuseIdentifier: "agendaSectionCell")
        agendaTableView.register(UINib(nibName: "AgendaTopicCell", bundle: nil), forCellReuseIdentifier: "agendaTopicCell")
        tableView.isHidden = false
        agendaTableView.isHidden = true
    }
    func configView() {
        self.view.backgroundColor = Style.bgColor
        view.addSubview(calenderView)
        calenderView.delegate = self
        calenderView.topAnchor.constraint(equalTo: agendaButton.topAnchor, constant: 40).isActive=true
        calenderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive=true
        calenderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive=true
        calenderView.heightAnchor.constraint(equalToConstant: 365).isActive=true
        agendaButton.addTarget(self, action: #selector(agendaClicked), for: .touchUpInside)
        monthlyButton.addTarget(self, action: #selector(monthlyClicked), for: .touchUpInside)
    }
    func getData() {
        ACRequest.GET_CALENDAR_DATA(childID: ACData.HOMEDATA.childID, eventDate: currentDate, successCompletion: { (calendarData) in
            ACData.CALENDARDATA = calendarData
            print(calendarData.event_date)
            SVProgressHUD.dismiss()
            DispatchQueue.main.async {
                self.calenderView.isHidden = false
                self.tableView.isHidden = false
                self.agendaTableView.isHidden = true
                self.tableView.reloadData()
            }
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func getAgendaData() {
        ACRequest.GET_CALENDAR_AGENDA_LIST(childID: ACData.HOMEDATA.childID, successCompletion: { (calendarAgendaDatas) in
            ACData.CALENDARAGENDALISTDATA = calendarAgendaDatas
            SVProgressHUD.dismiss()
            DispatchQueue.main.async {
                self.calenderView.isHidden = true
                self.tableView.isHidden = true
                self.agendaTableView.isHidden = false
                self.agendaTableView.reloadData()
            }
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calenderView.myCollectionView.collectionViewLayout.invalidateLayout()
    }
    @objc func agendaClicked() {
        monthlyButton.backgroundColor = UIColor.white
        monthlyButton.setTitleColor(ACColor.MAIN, for: .normal)
        monthlyButton.layer.borderColor = ACColor.MAIN.cgColor
        monthlyButton.layer.borderWidth = 1
        
        agendaButton.backgroundColor = ACColor.MAIN
        agendaButton.setTitleColor(UIColor.white, for: .normal)
        
        getAgendaData()
    }
    @objc func monthlyClicked() {
        agendaButton.backgroundColor = UIColor.white
        agendaButton.setTitleColor(ACColor.MAIN, for: .normal)
        agendaButton.layer.borderColor = ACColor.MAIN.cgColor
        agendaButton.layer.borderWidth = 1
        
        monthlyButton.backgroundColor = ACColor.MAIN
        monthlyButton.setTitleColor(UIColor.white, for: .normal)
        
        getData()
    }
    func didTapDate(date: String, available: Bool) {
        if available == true {
            currentDate = date
            getData()
        } else {
            showAlert()
        }
    }
    fileprivate func showAlert(){
        let alert = UIAlertController(title: "Unavailable", message: "This slot is already booked.\nPlease choose another date.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.tableView {
            return 1
        } else {
            return ACData.CALENDARAGENDALISTDATA.count
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            guard let object = ACData.CALENDARDATA else {
                return 0
            }
            return 8 + object.assignment.count + object.announcement.count + object.competition.count + object.personal_notes.count + object.exams.count + object.events.count + object.sessions.count + object.course_schedule.count
        } else {
            return ACData.CALENDARAGENDALISTDATA[section].agendas.count
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView == agendaTableView ? 55.0 : 0.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == agendaTableView {
            let bgView = UIView(frame: CGRect(x: 0, y: 0, width: agendaTableView.frame.size.width, height: 55))
            bgView.backgroundColor = ACColor.MAIN
            let dateLabel = UILabel(frame: CGRect(x: 10, y: 0, width: bgView.frame.size.width - 10, height: 55))
            dateLabel.font = UIFont.systemFont(ofSize: 14.0)
            dateLabel.textColor = .white
            dateLabel.numberOfLines = 0
            dateLabel.text = ACData.CALENDARAGENDALISTDATA[section].date
            bgView.addSubview(dateLabel)
            return bgView
        } else {
            return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.tableView {
            if indexPath.row == 0 &&
                indexPath.row == ACData.CALENDARDATA.assignment.count + 1 &&
                indexPath.row == ACData.CALENDARDATA.assignment.count + 2 + ACData.CALENDARDATA.announcement.count &&
                indexPath.row == ACData.CALENDARDATA.assignment.count + 3 + ACData.CALENDARDATA.announcement.count + ACData.CALENDARDATA.competition.count &&
                indexPath.row == ACData.CALENDARDATA.assignment.count + 4 + ACData.CALENDARDATA.announcement.count + ACData.CALENDARDATA.competition.count + ACData.CALENDARDATA.personal_notes.count &&
                indexPath.row == ACData.CALENDARDATA.assignment.count + 5 + ACData.CALENDARDATA.announcement.count + ACData.CALENDARDATA.competition.count + ACData.CALENDARDATA.personal_notes.count + ACData.CALENDARDATA.exams.count &&
                indexPath.row == ACData.CALENDARDATA.assignment.count + 6 + ACData.CALENDARDATA.announcement.count + ACData.CALENDARDATA.competition.count + ACData.CALENDARDATA.personal_notes.count + ACData.CALENDARDATA.exams.count + ACData.CALENDARDATA.events.count &&
                indexPath.row == ACData.CALENDARDATA.assignment.count + 7 + ACData.CALENDARDATA.announcement.count + ACData.CALENDARDATA.competition.count + ACData.CALENDARDATA.personal_notes.count + ACData.CALENDARDATA.exams.count + ACData.CALENDARDATA.events.count + ACData.CALENDARDATA.sessions.count &&
                indexPath.row == ACData.CALENDARDATA.assignment.count + 8 + ACData.CALENDARDATA.announcement.count + ACData.CALENDARDATA.competition.count + ACData.CALENDARDATA.personal_notes.count + ACData.CALENDARDATA.exams.count + ACData.CALENDARDATA.events.count + ACData.CALENDARDATA.sessions.count + ACData.CALENDARDATA.course_schedule.count {
                return 35
            } else {
                return 44
            }
        } else {
            return 55
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            if indexPath.row == 0{
                let cell = (tableView.dequeueReusableCell(withIdentifier: "calendarSectionCell", for: indexPath) as? CalendarSectionCell)!
                cell.calendarSectionLbl.text = "Assignment(s)"
                return cell
            } else if indexPath.row > 0 && indexPath.row < ACData.CALENDARDATA.assignment.count + 1 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as? TopicCell)!
                
                return cell
            } else if indexPath.row == ACData.CALENDARDATA.assignment.count + 1 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "calendarSectionCell", for: indexPath) as? CalendarSectionCell)!
                cell.calendarSectionLbl.text = "Announcement(s)"
                return cell
            } else if indexPath.row > ACData.CALENDARDATA.assignment.count + 1 && indexPath.row < ACData.CALENDARDATA.assignment.count + 2 + ACData.CALENDARDATA.announcement.count {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as? TopicCell)!
                
                return cell
            } else if indexPath.row == ACData.CALENDARDATA.assignment.count + 2 + ACData.CALENDARDATA.announcement.count {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "calendarSectionCell", for: indexPath) as? CalendarSectionCell)!
                cell.calendarSectionLbl.text = "Competition(s)"
                return cell
            } else if indexPath.row > ACData.CALENDARDATA.assignment.count + 2 + ACData.CALENDARDATA.announcement.count && indexPath.row < ACData.CALENDARDATA.assignment.count + 3 + ACData.CALENDARDATA.announcement.count + ACData.CALENDARDATA.competition.count {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as? TopicCell)!
                
                return cell
            } else if indexPath.row == ACData.CALENDARDATA.assignment.count + 3 + ACData.CALENDARDATA.announcement.count + ACData.CALENDARDATA.competition.count {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "calendarSectionCell", for: indexPath) as? CalendarSectionCell)!
                cell.calendarSectionLbl.text = "Personal Note(s)"
                return cell
            } else if indexPath.row > ACData.CALENDARDATA.assignment.count + 3 + ACData.CALENDARDATA.announcement.count + ACData.CALENDARDATA.competition.count && indexPath.row < ACData.CALENDARDATA.assignment.count + 4 + ACData.CALENDARDATA.announcement.count + ACData.CALENDARDATA.competition.count + ACData.CALENDARDATA.personal_notes.count {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as? TopicCell)!
                
                return cell
            } else if indexPath.row == ACData.CALENDARDATA.assignment.count + 4 + ACData.CALENDARDATA.announcement.count + ACData.CALENDARDATA.competition.count + ACData.CALENDARDATA.personal_notes.count {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "calendarSectionCell", for: indexPath) as? CalendarSectionCell)!
                cell.calendarSectionLbl.text = "Exam(s)"
                return cell
            } else if indexPath.row > ACData.CALENDARDATA.assignment.count + 4 + ACData.CALENDARDATA.announcement.count + ACData.CALENDARDATA.competition.count + ACData.CALENDARDATA.personal_notes.count && indexPath.row < ACData.CALENDARDATA.assignment.count + 5 + ACData.CALENDARDATA.announcement.count + ACData.CALENDARDATA.competition.count + ACData.CALENDARDATA.personal_notes.count + ACData.CALENDARDATA.exams.count {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as? TopicCell)!
                
                return cell
            } else if indexPath.row == ACData.CALENDARDATA.assignment.count + 5 + ACData.CALENDARDATA.announcement.count + ACData.CALENDARDATA.competition.count + ACData.CALENDARDATA.personal_notes.count + ACData.CALENDARDATA.exams.count {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "calendarSectionCell", for: indexPath) as? CalendarSectionCell)!
                cell.calendarSectionLbl.text = "Event(s)"
                return cell
            } else if indexPath.row > ACData.CALENDARDATA.assignment.count + 5 + ACData.CALENDARDATA.announcement.count + ACData.CALENDARDATA.competition.count + ACData.CALENDARDATA.personal_notes.count + ACData.CALENDARDATA.exams.count && indexPath.row < ACData.CALENDARDATA.assignment.count + 6 + ACData.CALENDARDATA.announcement.count + ACData.CALENDARDATA.competition.count + ACData.CALENDARDATA.personal_notes.count + ACData.CALENDARDATA.exams.count + ACData.CALENDARDATA.events.count {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as? TopicCell)!
                
                return cell
            } else if indexPath.row == ACData.CALENDARDATA.assignment.count + 6 + ACData.CALENDARDATA.announcement.count + ACData.CALENDARDATA.competition.count + ACData.CALENDARDATA.personal_notes.count + ACData.CALENDARDATA.exams.count + ACData.CALENDARDATA.events.count {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "calendarSectionCell", for: indexPath) as? CalendarSectionCell)!
                cell.calendarSectionLbl.text = "Schedule(s)"
                return cell
            } else if indexPath.row > ACData.CALENDARDATA.assignment.count + 6 + ACData.CALENDARDATA.announcement.count + ACData.CALENDARDATA.competition.count + ACData.CALENDARDATA.personal_notes.count + ACData.CALENDARDATA.exams.count + ACData.CALENDARDATA.events.count && indexPath.row < ACData.CALENDARDATA.assignment.count + 7 + ACData.CALENDARDATA.announcement.count + ACData.CALENDARDATA.competition.count + ACData.CALENDARDATA.personal_notes.count + ACData.CALENDARDATA.exams.count + ACData.CALENDARDATA.events.count + ACData.CALENDARDATA.sessions.count {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as? ScheduleCell)!
                if indexPath.row%2 != 0 {
                    cell.scheduleList.backgroundColor = ACColor.MAIN
                    cell.subjectLbl.textColor = UIColor.white
                    cell.scheduleTimeLbl?.textColor = UIColor.white
                }
                else{
                    cell.scheduleList.backgroundColor = UIColor.white
                    cell.subjectLbl.textColor = ACColor.OLD_BLUE
                    cell.scheduleTimeLbl.textColor = ACColor.OLD_BLUE
                }
                return cell
            } else if indexPath.row == ACData.CALENDARDATA.assignment.count + 7 + ACData.CALENDARDATA.announcement.count + ACData.CALENDARDATA.competition.count + ACData.CALENDARDATA.personal_notes.count + ACData.CALENDARDATA.exams.count + ACData.CALENDARDATA.events.count + ACData.CALENDARDATA.sessions.count {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "calendarSectionCell", for: indexPath) as? CalendarSectionCell)!
                cell.calendarSectionLbl.text = "Course(s)"
                return cell
            } else if indexPath.row == ACData.CALENDARDATA.assignment.count + 7 + ACData.CALENDARDATA.announcement.count + ACData.CALENDARDATA.competition.count + ACData.CALENDARDATA.personal_notes.count + ACData.CALENDARDATA.exams.count + ACData.CALENDARDATA.events.count + ACData.CALENDARDATA.sessions.count + 1{
                let cell = (tableView.dequeueReusableCell(withIdentifier: "addNewEventCell", for: indexPath) as? AddNewEventCell)!
                return cell
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as? ScheduleCell)!
                if indexPath.row%2 != 0 {
                    cell.scheduleList.backgroundColor = ACColor.MAIN
                    cell.subjectLbl.textColor = UIColor.white
                    cell.scheduleTimeLbl?.textColor = UIColor.white
                } else {
                    cell.scheduleList.backgroundColor = UIColor.white
                    cell.subjectLbl.textColor = ACColor.OLD_BLUE
                    cell.scheduleTimeLbl.textColor = ACColor.OLD_BLUE
                }
                return cell
            }
        } else {
            let cell = (agendaTableView.dequeueReusableCell(withIdentifier: "agendaTopicCell", for: indexPath) as? AgendaTopicCell)!
            cell.agendaTopicObj = ACData.CALENDARAGENDALISTDATA[indexPath.section].agendas[indexPath.row]
            cell.dividerView.isHidden = false
            return cell
        }
    }
}
