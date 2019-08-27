//
//  HomeRoomUpcomingSessionCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class HomeRoomUpcomingSessionCell: UITableViewCell {

    @IBOutlet weak var chapterNameLbl: UILabel!{
        didSet{
            chapterNameLbl.textColor = ACColor.MAIN
        }
    }
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color:  UIColor.gray, shadowRadius: 3.0, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
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
