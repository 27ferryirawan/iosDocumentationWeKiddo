//
//  CompetitionDetailCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 24/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class CompetitionDetailCell: UITableViewCell {

    @IBOutlet weak var contentEmail: UILabel!
    @IBOutlet weak var contentPhoneNumber: UILabel!
    @IBOutlet weak var contentParticipant: UILabel!
    @IBOutlet weak var contentCategoryLabel: UILabel!
    @IBOutlet weak var contentCategoryImage: UIImageView!
    @IBOutlet weak var contentDesc: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    var competitionObjc: CompetitionDetailModel? {
        didSet {
            cellConfig()
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
    func cellConfig() {
        guard let object = competitionObjc else {
            return
        }
        contentImage.sd_setImage(
            with: URL(string: "\(object.competition_image)"),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        contentDesc.text = object.competition_description
        contentCategoryImage.sd_setImage(
            with: URL(string: "\(object.competition_category_image)"),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        contentCategoryLabel.text = object.competition_category_title
        contentParticipant.text = object.competition_participant
        contentPhoneNumber.text = "Telp: \(object.competition_phone)"
        contentEmail.text = "Email: \(object.competition_email)"
    }
}
