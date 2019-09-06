//
//  TaskListAdminCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 01/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol TaskListAdminCellDelegate: class {
    func toDetailTask()
}

class TaskListAdminCell: UITableViewCell {
    
    @IBOutlet weak var contentButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    weak var delegate: TaskListAdminCellDelegate?
    var indexObject: Int!
    var isHistory = Bool()
    @IBOutlet weak var taskStatusView: UIView! {
        didSet {
            taskStatusView.layer.cornerRadius = taskStatusView.frame.size.width/2
        }
    }
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color:  UIColor.gray, shadowRadius: 3.0, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    var detailNewObj: TaskListAdminModel? {
        didSet {
            cellConfigNew()
        }
    }
    var detailClassObj: TaskListAdminHistoryModel? {
        didSet {
            cellConfigClass()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        contentButton.addTarget(self, action: #selector(toDetailContent), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func toDetailContent() {
        if isHistory {
            guard let obj = detailClassObj else { return }
            ACRequest.POST_ADMIN_DETAIL_TASK(userId: ACData.LOGINDATA.userID, taskID: obj.task_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (result) in
                ACData.DETAILTASKADMINDATA = result
                SVProgressHUD.dismiss()
                self.delegate?.toDetailTask()
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        } else {
            guard let obj = detailNewObj else { return }
            ACRequest.POST_ADMIN_DETAIL_TASK(userId: ACData.LOGINDATA.userID, taskID: obj.task_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (result) in
                ACData.DETAILTASKADMINDATA = result
                SVProgressHUD.dismiss()
                self.delegate?.toDetailTask()
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        }
    }
    func cellConfigNew() {
        guard let obj = detailNewObj else { return }
        taskLabel.text = obj.title
        dateLabel.text = getMonth(time: obj.task_date)
    }
    func cellConfigClass() {
        guard let obj = detailClassObj else { return }
        taskLabel.text = obj.title
        dateLabel.text = getMonth(time: obj.task_date)
//        if obj.status == 0 {
//            taskStatusView.backgroundColor = .red
//        } else {
//            taskStatusView.backgroundColor = .white
//        }
    }
}

extension TaskListAdminCell {
    func getMonth(time: String) -> String {
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
        dateFormatterResult.dateFormat = "dd MMM yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
