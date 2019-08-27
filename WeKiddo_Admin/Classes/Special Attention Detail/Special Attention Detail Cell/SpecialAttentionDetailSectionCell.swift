//
//  SpecialAttentionDetailSectionCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 30/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class SpecialAttentionDetailSectionCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.borderColor = UIColor.lightGray.cgColor
            bgView.layer.borderWidth = 1.0
            bgView.backgroundColor = ACColor.MAIN
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
    
}
