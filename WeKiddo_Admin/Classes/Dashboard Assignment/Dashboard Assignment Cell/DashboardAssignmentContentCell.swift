//
//  DashboardAssignmentContentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 21/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol DashboardAssignmentContentCellDelegate: class {
    func toAssignmentList()
}

class DashboardAssignmentContentCell: UITableViewCell {

    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var rightView: UIView! {
        didSet {
            rightView.layer.borderColor = UIColor.lightGray.cgColor
            rightView.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var leftView: UIView! {
        didSet {
            leftView.layer.borderColor = UIColor.lightGray.cgColor
            leftView.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var statisticView: UIView! {
        didSet {
            statisticView.layer.cornerRadius = 5.0
            statisticView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.borderColor = UIColor.lightGray.cgColor
            bgView.layer.borderWidth = 1.0
            bgView.layer.cornerRadius = 5.0
            bgView.layer.masksToBounds = true
        }
    }
    
    weak var delegate: DashboardAssignmentContentCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func detailAction(_ sender: UIButton) {
        self.delegate?.toAssignmentList()
    }
    
}
