//
//  AddCalendarCell.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 09/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class AddCalendarCell: UITableViewCell {

    @IBOutlet weak var saveBtn: UIButton!{
        didSet {
        saveBtn.layer.cornerRadius = 5
        saveBtn.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var discardBtn: UIButton!{
        didSet {
            discardBtn.layer.cornerRadius = 5
            discardBtn.clipsToBounds = true
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
