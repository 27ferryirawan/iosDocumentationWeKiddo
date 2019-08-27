//
//  EditEventDescCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 28/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class EditEventDescCell: UITableViewCell {

    @IBOutlet weak var descText: UILabel!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var bgView: UIView!
    var detailObj: DescriptionModel? {
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
        titleText.text = obj.titleText
        descText.text = obj.descText
    }
}
