//
//  AddSubjectTeacherSessionCollectionCell.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 20/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol AddSubjectTeacherSessionCollectionCellDelegate: class {
    func sessionClickedAt(section: Int, index: Int)
}

class AddSubjectTeacherSessionCollectionCell: UICollectionViewCell {
    
    var sessionStatus = Bool()
    var sessionSelected = [SubjectTeacherSessionSelectedModel]()
    var section = 0
    var index = 0
    weak var delegate: AddSubjectTeacherSessionCollectionCellDelegate?
    @IBOutlet weak var sessionButton: UIButton!
    @IBOutlet weak var sessionImageStatus: UIImageView!
    @IBOutlet weak var sessionLabel: UILabel!
    var detailEditObj: SubjectTeacherDetailSessionWeekSessionListModel? {
        didSet {
            cellEditConfig()
        }
    }
    var detailObj: SubjectTeacherParamWeekSessionsSessionModel? {
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
    func cellEditConfig() {
        guard let obj = detailEditObj else { return }
        sessionLabel.text = "Session \(obj.session_count)"
    }
    @objc func sessionClicked() {
        self.delegate?.sessionClickedAt(section: section, index: index)
    }
}
