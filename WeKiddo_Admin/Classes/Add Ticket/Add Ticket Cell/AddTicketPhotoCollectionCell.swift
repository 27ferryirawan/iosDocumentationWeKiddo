//
//  AddTicketPhotoCollectionCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 04/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class AddTicketPhotoCollectionCell: UICollectionViewCell {

    @IBOutlet weak var contentImage: UIImageView!
    var detailObj: TicketMediaModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        contentImage.sd_setImage(
            with: URL(string: (obj.media_url)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
}
