//
//  EditEventBannerCollectionCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 28/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class EditEventBannerCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var contentImage: UIImageView!
    var contentObj: AttachmentBannerModel? {
        didSet {
            cellConfig()
        }
    }
    var detailObj: BannerMediaModel? {
        didSet {
            cellConfigEdit()
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
    func cellConfigEdit() {
        guard let obj = detailObj else {
            return
        }
        contentImage.sd_setImage(
            with: URL(string: (obj.file_url)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
}
