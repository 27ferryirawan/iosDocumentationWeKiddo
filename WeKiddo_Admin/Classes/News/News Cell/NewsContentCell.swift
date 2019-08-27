//
//  NewsContentCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 03/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class NewsContentCell: UITableViewCell {

    @IBOutlet weak var viewLeft: UIView!
    @IBOutlet weak var imageLeft: UIImageView!
    @IBOutlet weak var labelLeft: UILabel!
    @IBOutlet weak var buttonLeft: UIButton!
    
    @IBOutlet weak var viewRight: UIView!
    @IBOutlet weak var imageRight: UIImageView!
    @IBOutlet weak var labelRight: UILabel!
    @IBOutlet weak var buttonRight: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
