//
//  assignmentButtonCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol AssignmentDelegate {
    func goToAssignment()
}

class assignmentButtonCell: UITableViewCell {
    var delegate: AssignmentDelegate? = nil
    @IBOutlet weak var seeMoreAssignmentBtn: UIButton!{
        didSet{
            seeMoreAssignmentBtn.layer.cornerRadius = 5
            seeMoreAssignmentBtn.clipsToBounds = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        seeMoreAssignmentBtn.addTarget(self, action: #selector(seeAllAssignment), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func seeAllAssignment() {
        ACData.ASSIGNMENTMODULMODEL.removeAll()
        ACRequest.GET_ASSIGNMENT_DATA(childID: ACData.HOMEDATA.childID, successCompletion: { (assignmentData) in
            ACData.ASSIGNMENTMODULMODEL = assignmentData
            SVProgressHUD.dismiss()
            self.delegate?.goToAssignment()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    
}
