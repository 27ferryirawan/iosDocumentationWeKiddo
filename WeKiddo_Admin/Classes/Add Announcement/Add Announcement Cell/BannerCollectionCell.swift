//
//  BannerCollectionCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 10/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class BannerCollectionCell: UICollectionViewCell {

    @IBOutlet weak var contentImage: UIImageView!
    var contentObj: AttachmentBannerModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func cellConfig() {
        guard let obj = contentObj else { return }
        contentImage.sd_setImage(
            with: URL(string: (obj.file_url)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
}
