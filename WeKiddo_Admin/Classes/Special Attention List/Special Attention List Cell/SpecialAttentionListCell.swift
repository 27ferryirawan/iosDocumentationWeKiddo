//
//  SpecialAttentionListCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 29/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol SpecialAttentionListCellDelegate: class {
    func toDetailSpecialAttentionBySubject()
}

class SpecialAttentionListCell: UITableViewCell {

    @IBOutlet weak var contentButton: UIButton!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var countLabek: UILabel!
    @IBOutlet weak var countView: UIView!{
        didSet{
            countView.layer.cornerRadius = countView.frame.size.width/2
        }
    }
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color: UIColor.lightGray, shadowRadius: 3.0, shadowOpactiy: 1.0, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    weak var delegate: SpecialAttentionListCellDelegate?
    var detailSubjectObj: SpecialAttentionBySubjectListModel? {
        didSet {
            cellConfig()
        }
    }
    var detailClassObj: SpecialAttentionByClassListModel? {
        didSet {
            cellClassConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailSubjectObj else { return }
        nameLabel.text = obj.child_name
        classLabel.text = "\(obj.school_class) - NIS: \(obj.child_nis)"
        countLabek.text = obj.score
        subjectLabel.text = obj.subject_name
    }
    func cellClassConfig() {
        guard let obj = detailClassObj else { return }
        nameLabel.text = obj.child_name
        classLabel.text = "\(obj.school_class) - NIS: \(obj.child_nis)"
        countLabek.text = obj.score
        subjectLabel.text = obj.subject_id
    }
    @objc func toDetail() {
    }
}
