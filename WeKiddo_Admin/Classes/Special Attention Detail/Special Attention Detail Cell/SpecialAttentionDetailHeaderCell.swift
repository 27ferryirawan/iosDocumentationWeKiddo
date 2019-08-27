//
//  SpecialAttentionDetailHeaderCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 30/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class SpecialAttentionDetailHeaderCell: UITableViewCell {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreView: UIView! {
        didSet {
            scoreView.layer.cornerRadius = scoreView.frame.size.width / 2
            scoreView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var chapterLabel: UILabel!
    @IBOutlet weak var radianLabel: UILabel!
    @IBOutlet weak var passingGradeLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color: UIColor.lightGray, shadowRadius: 2.0, shadowOpactiy: 1.0, shadowOffsetWidth: 1, shadowOffsetHeight: 1)
        }
    }
    var detailObj: SpecialAttentionBySubjectDetailModel? {
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
        nameLabel.text = obj.child_name
        classLabel.text = "\(obj.school_class) - \(obj.child_nis)"
        passingGradeLabel.text = "Passing Grade : \(obj.passing_grade)"
        radianLabel.text = "Radian : \(obj.radian_score)"
        chapterLabel.text = obj.subject_name
        scoreLabel.text = obj.score
    }
}
