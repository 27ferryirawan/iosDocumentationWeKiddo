//
//  WorksheetStudentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 22/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class WorksheetStudentCell: UITableViewCell {

    @IBOutlet weak var imageStatut: UIImageView!
    @IBOutlet weak var studentStatus: UILabel!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentImage: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    var detailObj: CoordinatorAssignmentListStudentPerClass? {
        didSet {
            cellConfig()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellConfig() {
        guard let obj = detailObj else { return }
        self.studentImage.sd_setImage(
            with: URL(string: (obj.child_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        studentName.text = "\(obj.child_name) \n \(obj.child_nis)"
        studentStatus.text = obj.is_submit ? "Submitted" : "Not Submitted"
        imageStatut.image = obj.is_submit ? UIImage(named: "icon_green_check") : UIImage(named: "icon_red_cross")
    }
    
}
