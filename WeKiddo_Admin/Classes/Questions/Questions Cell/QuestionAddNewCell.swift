//
//  QuestionAddNewCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 06/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class QuestionAddNewCell: UITableViewCell {

    @IBOutlet weak var addQuestionBtn: UIButton!{
        didSet{
            addQuestionBtn.layer.cornerRadius = 5
            addQuestionBtn.clipsToBounds = true
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
