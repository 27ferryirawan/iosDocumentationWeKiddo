//
//  HomeRoomSpecialAttentionCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol HomeRoomSpecialAttentionCellDelegate: class {
    func toDetailSpecialAttention(isClass: Bool)
}

class HomeRoomSpecialAttentionCell: UITableViewCell {
    
    @IBOutlet weak var contentButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nisLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    weak var delegate: HomeRoomSpecialAttentionCellDelegate?
    @IBOutlet weak var subjectScoreView: UIView!{
        didSet{
            subjectScoreView.layer.cornerRadius = subjectScoreView.frame.size.width/2
        }
    }
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color:  UIColor.gray, shadowRadius: 3.0, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    var detailClassObj: DashboardModelTaskList? {
        didSet {
            cellConfigClass()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        contentButton.addTarget(self, action: #selector(toDetail), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func toDetail() {
//        guard let obj = detailClassObj else { return }
//        ACRequest.POST_SPECIAL_ATTENTION_DETAIL_BY_CLASS(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, classID: obj.school_class_id, childID: obj.child_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
//            SVProgressHUD.dismiss()
//            ACData.SPECIALATTENTIONBYCLASSDETAILDATA = jsonDatas
//            self.delegate?.toDetailSpecialAttention(isClass: self.isClass)
//        }) { (message) in
//            SVProgressHUD.dismiss()
//            ACAlert.show(message: message)
//        }
    }
    func cellConfigClass() {
//        guard let obj = detailClassObj else { return }
//        nameLabel.text = obj.child_name
//        nisLabel.text = obj.child_nis
//        scoreLabel.text = obj.score
    }
}
