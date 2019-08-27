//
//  HomeRoomHeaderCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 17/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage

protocol HomeRoomHeaderCellDelegate: class {
    func toSessionDetail()
    func toSeeMoreSession()
}

class HomeRoomHeaderCell: UITableViewCell {

    @IBOutlet weak var schoolView: UIView! {
        didSet {
            schoolView.layer.borderColor = ACColor.MAIN.cgColor
            schoolView.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var seeAllSessionButton: UIButton!{
        didSet {
            seeAllSessionButton.layer.cornerRadius = 5
            seeAllSessionButton.clipsToBounds = true
        }
    }
    @IBOutlet weak var sessionTime: UILabel!
    @IBOutlet weak var sessionClass: UILabel!
    @IBOutlet weak var sessionName: UILabel!{
        didSet{
            sessionName.textColor = ACColor.MAIN
        }
    }
    @IBOutlet weak var sessionSubject: UILabel!
    @IBOutlet weak var viewUpcomingSession: UIView! {
        didSet {
        viewUpcomingSession.setBorderShadow(color:  UIColor.gray, shadowRadius: 3.0, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var schoolImage: UIImageView!{
        didSet{
            schoolImage.layer.borderWidth = 0.5
            schoolImage.layer.borderColor = ACColor.MAIN.cgColor
        }
    }
    @IBOutlet weak var welcomeLabel: UILabel!
    var detailObj: DashboardModel? {
        didSet {
            cellConfig()
        }
    }
    weak var delegate: HomeRoomHeaderCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        seeAllSessionButton.addTarget(self, action: #selector(seeMore), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func seeMore() {
        ACData.UPCOMINGSESSIONLISTDATA.removeAll()
        ACRequest.POST_SEE_MORE_UPCOMING_SESSION(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, page: 1, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
            SVProgressHUD.dismiss()
            ACData.UPCOMINGSESSIONLISTDATA = jsonDatas
            self.delegate?.toSeeMoreSession()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        welcomeLabel.text = "Welcome, \(obj.home_profile_teacher_name)"
        self.schoolImage.sd_setImage(
            with: URL(string: (obj.home_profile_school_logo)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        schoolName.text = obj.home_profile_school_name
        if obj.upcoming_session_school_subject_name.isEmpty {
           sessionSubject.text = "No Session Available"
            sessionName.text = ""
            sessionClass.text = ""
            sessionTime.text = ""
            seeAllSessionButton.isUserInteractionEnabled = false
        } else {
            sessionSubject.text = "\(obj.upcoming_session_school_subject_name) - \(obj.upcoming_session_school_chapter_id)"
            sessionName.text = obj.upcoming_session_school_subject_id
            sessionClass.text = obj.upcoming_session_school_school_class
            sessionTime.text = "\(toDateString(time: obj.upcoming_session_school_start_time)) - \(toDateString(time: obj.upcoming_session_school_end_time))"
            seeAllSessionButton.isUserInteractionEnabled = true
        }
    }
}

extension HomeRoomHeaderCell {
    func toDateString(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm:ss"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        
        // then convert date to string again
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "HH:mm"
        let stringDate = dateFormatterResult.string(from: date)
        
        return stringDate
    }
}
