//
//  AddExamSessionCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 26/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol AddExamSessionCellDelegate: class {
    func sessionClickedAt(week: Int, session: Int)
}

class AddExamSessionCell: UICollectionViewCell {

    var sessionStatus = Bool()
    var sessionSelected = [ExamSessionSelectedModel]()
    var currentWeek = 0
    var currentSession = 0
    weak var delegate: AddExamSessionCellDelegate?
    @IBOutlet weak var sessionButton: UIButton!
    @IBOutlet weak var sessionImageStatus: UIImageView!
    @IBOutlet weak var sessionLabel: UILabel!
    var detailObj: ExamClassSessionModel? {
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
        self.delegate?.sessionClickedAt(week: currentWeek, session: obj.session_count)
    }
}
