//
//  ExamContentCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 05/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol ExamContentCellDelegate: class {
    func toExamDetail()
}

class ExamContentCell: UITableViewCell {

    @IBOutlet weak var examButton: UIButton!
    @IBOutlet weak var examContent: UILabel!
    @IBOutlet weak var examDate: UILabel!
    var examObj: ExamsModel? {
        didSet {
            cellConfig()
        }
    }
    @IBOutlet weak var examList: UIView!{
        didSet{
            examList.setBorderShadow(color:  UIColor.gray, shadowRadius: 3.0, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    
    @IBOutlet weak var roundedSquare: UIView!{
        didSet {
            roundedSquare.layer.cornerRadius = roundedSquare.frame.size.width/2
            roundedSquare.clipsToBounds = true
        }
    }
    
    weak var delegate: ExamContentCellDelegate?
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
        examContent.text = obj.school_exam_subject
        examDate.text = "\(convertDate(time: obj.school_exam_date)) AM | \(obj.subject_name)"
    }
    @objc func goToExamDetail() {
        guard let obj = examObj else {
            return
        }
        ACRequest.GET_EXAM_DETAIL(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, examID: obj.school_exam_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (detailData) in
            SVProgressHUD.dismiss()
            self.delegate?.toExamDetail()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
}

extension ExamContentCell {
    func convertDate(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        // then convert date to string again
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "EEEE, dd MMMM yyyy - HH:mm"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
