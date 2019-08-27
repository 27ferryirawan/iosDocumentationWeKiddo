//
//  EditExamSessionCollectionCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 25/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol EditExamSessionCollectionCellDelegate: class {
    func sessionClickedAt(week: Int, session: Int, checked: Bool)
}

class EditExamSessionCollectionCell: UICollectionViewCell {

    var sessionStatus = Bool()
    var sessionSelected = [ExamSessionWeekSelectedModel]()
    var section = 0
    var index = 0
    var currentWeek = 0
    var currentSession = 0
    weak var delegate: EditExamSessionCollectionCellDelegate?
    @IBOutlet weak var sessionButton: UIButton!
    @IBOutlet weak var sessionImageStatus: UIImageView!
    @IBOutlet weak var sessionLabel: UILabel!
    var detailObj: ExamEditSessionModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        sessionButton.addTarget(self, action: #selector(sessionClicked), for: .touchUpInside)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        sessionLabel.text = "Session \(obj.session_count)"
    }
    @objc func sessionClicked() {
        guard let obj = detailObj else { return }
        if obj.is_checked {
            self.delegate?.sessionClickedAt(week: currentWeek, session: obj.session_count, checked: false)
        } else {
            self.delegate?.sessionClickedAt(week: currentWeek, session: obj.session_count, checked: true)
        }

    }
}
