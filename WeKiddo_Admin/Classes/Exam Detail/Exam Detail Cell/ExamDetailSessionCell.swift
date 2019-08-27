//
//  ExamDetailSessionCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 19/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class ExamDetailSessionCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    var detailObj: SessionListModel? {
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
        contentLabel.text = "- Session \(obj.session_count)"
    }
}
