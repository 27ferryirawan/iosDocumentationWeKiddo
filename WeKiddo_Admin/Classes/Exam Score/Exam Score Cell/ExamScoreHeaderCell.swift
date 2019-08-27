//
//  ExamScoreHeaderCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 24/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class ExamScoreHeaderCell: UITableViewCell {

    @IBOutlet weak var radianLabel: UILabel!
    @IBOutlet weak var radianView: UIView! {
        didSet {
            radianView.layer.cornerRadius = radianView.frame.size.width/2
            radianView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var passingGradeLabel: UILabel!
    @IBOutlet weak var passingGradeView: UIView! {
        didSet {
            passingGradeView.layer.cornerRadius = passingGradeView.frame.size.width/2
            passingGradeView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var chapterLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    var detailObj: ExamRemedyScoreListModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        subjectLabel.text = obj.subject_name
        chapterLabel.text = obj.chapter_name
        passingGradeLabel.text = "\(obj.passing_grade)"
        radianLabel.text = "\(obj.radiant)"
    }
}
