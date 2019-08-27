//
//  SubjectDetailUpcommingSessionCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 11/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class SubjectDetailUpcommingSessionCell: UITableViewCell {

    @IBOutlet weak var subjectDateLabel: UILabel!
    @IBOutlet weak var subjectTopicLabel: UILabel!
    @IBOutlet weak var subjectTitleLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    var detailObj: SubjectDetailUpcomingSessionModel? {
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
        subjectTitleLabel.text = obj.chapter_id
        subjectTopicLabel.text = obj.chapter_name
    }
}
