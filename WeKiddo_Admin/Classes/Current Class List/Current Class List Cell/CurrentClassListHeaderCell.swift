//
//  CurrentClassListHeaderCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 30/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class CurrentClassListHeaderCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var subjectChapterLabel: UILabel!
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
