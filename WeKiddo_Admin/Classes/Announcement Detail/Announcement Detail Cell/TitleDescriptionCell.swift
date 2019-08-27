//
//  TitleDescriptionCell.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 01/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class TitleDescriptionCell: UITableViewCell {
  
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    var fieldObj: AnnouncementFieldModel? {
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
        guard let obj = fieldObj else {
            return
        }
        titleLbl.text = obj.title_text
        descriptionLbl.text = obj.desc
    }
}
