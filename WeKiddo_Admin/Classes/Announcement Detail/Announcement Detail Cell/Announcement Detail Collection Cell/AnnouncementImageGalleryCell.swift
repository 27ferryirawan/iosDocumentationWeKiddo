//
//  AnnouncementImageGalleryCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 21/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class AnnouncementImageGalleryCell: UICollectionViewCell {

    @IBOutlet weak var contentImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    var detailObj: AnnouncementDetailMediasModel? {
        didSet {
            configCell()
        }
    }
    func configCell() {
        guard let obj = detailObj else { return }
        contentImage.sd_setImage(
            with: URL(string: obj.url),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
}
