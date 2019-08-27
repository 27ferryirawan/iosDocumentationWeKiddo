//
//  SubjectContentCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 20/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol SubjectContentCellDelegate: class {
    func toDetail()
}

class SubjectContentCell: UITableViewCell {

    @IBOutlet weak var subjectButton: UIButton!
    @IBOutlet weak var subjectAverage: UILabel!
    @IBOutlet weak var subjectName: UILabel!
    var subjObj: SubjectListModel? {
        didSet {
            cellConfig()
        }
    }
    weak var delegate: SubjectContentCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        subjectButton.addTarget(self, action: #selector(goToSubjectDetail), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = subjObj else {
            return
        }
        subjectName.text = obj.subject_name
        subjectAverage.text = "\(obj.passing_grade)/\(obj.radian)(AVG)"
    }
    @objc func goToSubjectDetail() {
        guard let obj = subjObj else {
            return
        }
        ACRequest.GET_SUBJECT_DETAIL(subjectID: obj.subject_id, childID: ACData.HOMEDATA.childID, successCompletion: { (subjectDetailData) in
            ACData.SUBJECTDETAILDATA = subjectDetailData
            SVProgressHUD.dismiss()
            self.delegate?.toDetail()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
}
