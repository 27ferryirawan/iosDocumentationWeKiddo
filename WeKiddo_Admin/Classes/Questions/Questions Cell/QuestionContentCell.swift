//
//  QuestionContentCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 06/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class QuestionContentCell: UITableViewCell {

    @IBOutlet weak var dividerView: UIView!
    @IBOutlet weak var chatQtyView: UIView!{
        didSet{
            chatQtyView.layer.cornerRadius = chatQtyView.frame.size.width/2
            chatQtyView.clipsToBounds = true
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
