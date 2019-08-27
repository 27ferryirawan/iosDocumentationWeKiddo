//
//  SpecialAttentionDetailByClassContentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 05/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class SpecialAttentionDetailByClassContentCell: UITableViewCell {

    @IBOutlet weak var radianLabel: UILabel!
    @IBOutlet weak var passingGradeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color: UIColor.lightGray, shadowRadius: 2.0, shadowOpactiy: 0.5, shadowOffsetWidth: 1, shadowOffsetHeight: 1)
        }
    }
    var detailObj: SpecialAttentionByClassDetailScoreListModel? {
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
        scoreLabel.text = "\(obj.score)"
        passingGradeLabel.text = "\(obj.passing_grade)"
        radianLabel.text = "\(obj.radiant)"
    }
}
