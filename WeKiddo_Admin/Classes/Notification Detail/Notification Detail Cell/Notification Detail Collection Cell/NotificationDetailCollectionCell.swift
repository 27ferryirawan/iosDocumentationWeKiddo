//
//  NotificationDetailCollectionCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 18/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class NotificationDetailCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageContent: UIImageView!
    var detailObj: ApprovalDetailMediaModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func cellConfig() {
        guard let obj = detailObj else {
            return
        }
        imageContent.sd_setImage(
            with: URL(string: (obj.url)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
}

