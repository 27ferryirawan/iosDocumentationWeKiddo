//
//  HomeEventSectionCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class HomeEventSectionCell: UITableViewCell {

    @IBOutlet weak var roundedOne: UIView!{
        didSet{
            roundedOne.layer.cornerRadius = roundedOne.frame.size.width/2
        }
    }
    @IBOutlet weak var roundedTwo: UIView!{
        didSet{
            roundedTwo.layer.cornerRadius = roundedTwo.frame.size.width/2
        }
    }
    @IBOutlet weak var roundedThree: UIView!{
        didSet{
            roundedThree.layer.cornerRadius = roundedThree.frame.size.width/2
        }
    }
    @IBOutlet weak var roundedFour: UIView!{
        didSet{
            roundedFour.layer.cornerRadius = roundedFour.frame.size.width/2
        }
    }
    @IBOutlet weak var labelPaid: UILabel!
    @IBOutlet weak var viewPaid: UIView!
    @IBOutlet weak var labelReject: UILabel!
    @IBOutlet weak var viewReject: UIView!
    @IBOutlet weak var labelApprove: UILabel!
    @IBOutlet weak var viewApprove: UIView!
    @IBOutlet weak var labelPending: UILabel!
    @IBOutlet weak var viewPending: UIView!
    @IBOutlet weak var sectionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig(isEvent: Bool, isLatePayment: Bool, isPermission: Bool) {
        if isEvent {
            sectionLabel.text = "Event Monitoring"
            viewPaid.isHidden = false
            labelPaid.isHidden = false
            viewReject.isHidden = false
            labelReject.isHidden = false
            viewApprove.isHidden = false
            labelApprove.isHidden = false
            viewPending.isHidden = false
            labelPending.isHidden = false
        } else if isLatePayment {
            sectionLabel.text = "Late Payment"
            viewPaid.isHidden = true
            labelPaid.isHidden = true
            viewReject.isHidden = true
            labelReject.isHidden = true
            viewApprove.isHidden = true
            labelApprove.isHidden = true
            viewPending.isHidden = true
            labelPending.isHidden = true
        } else if isPermission {
            sectionLabel.text = "Permission Request"
            viewPaid.isHidden = true
            labelPaid.isHidden = true
            viewReject.isHidden = true
            labelReject.isHidden = true
            viewApprove.isHidden = true
            labelApprove.isHidden = true
            viewPending.isHidden = true
            labelPending.isHidden = true
        }
    }
}
