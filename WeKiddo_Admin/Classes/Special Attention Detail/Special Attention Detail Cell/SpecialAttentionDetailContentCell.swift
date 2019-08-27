//
//  SpecialAttentionDetailContentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 30/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class SpecialAttentionDetailContentCell: UITableViewCell {

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var examTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color: UIColor.lightGray, shadowRadius: 2.0, shadowOpactiy: 1.0, shadowOffsetWidth: 1, shadowOffsetHeight: 1)
        }
    }
    var detailObj: SpecialAttentionBySubjectDetailScoreListModel? {
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
        dateLabel.text = obj.finish_date
        examTypeLabel.text = obj.score_type_name
        descLabel.text = obj.note
        scoreLabel.text = "\(obj.score)"
    }
}
