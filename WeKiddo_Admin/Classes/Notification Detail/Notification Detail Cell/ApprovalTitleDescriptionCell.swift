//
//  TitleDescriptionCell.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 01/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class ApprovalTitleDescriptionCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!{
        didSet{
            titleLbl.textColor = ACColor.MAIN
        }
    }
    @IBOutlet weak var descriptionLbl: UILabel!
    var detailObj: ApprovalDetailFieldModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        titleLbl.text = obj.title_text
        descriptionLbl.text = obj.desc
    }
}
