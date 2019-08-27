//
//  ExamCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 07/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol ExamCellDelegate: class {
    func toExamDetail(withExamDetailIndex: String)
}

class ExamCell: UITableViewCell {

    @IBOutlet weak var examList: UIView!{
        didSet{
            examList.setBorderShadow(color:  UIColor.gray, shadowRadius: 1.0, shadowOpactiy: 0.5, shadowOffsetWidth: 1, shadowOffsetHeight: 1)
        }
    }
    @IBOutlet weak var examButton: UIButton!
    @IBOutlet weak var examTopic: UILabel!
    @IBOutlet weak var examDate: UILabel!
    @IBOutlet weak var examChapter: UILabel!
    
    var examObj: ExamListExamModel? {
        didSet {
            cellConfig()
        }
    }
    weak var delegate: ExamCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        examButton.addTarget(self, action: #selector(goToExamDetail), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = examObj else {
            return
        }
        examTopic.text = "\(obj.chapter_name) (\(obj.score_type_name))"
        examDate.text = "\(convertDate(time: obj.session_date)) - \(convertTime(time: obj.start_time)) AM"
        examChapter.text = "\(obj.school_class) - \(obj.subject_name) - \(obj.chapter_name)"
    }
    @objc func goToExamDetail() {
        guard let obj = examObj else {
            return
        }
        ACRequest.GET_EXAM_DETAIL(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, examID: obj.school_session_exam_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (detailData) in
            SVProgressHUD.dismiss()
            ACData.EXAMDETAILDATA = detailData
            self.delegate?.toExamDetail(withExamDetailIndex: obj.school_session_exam_id)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}

extension ExamCell {
    func convertDate(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        // then convert date to string again
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "EEEE, dd MMMM yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
    func convertTime(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH-mm-ss"
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
