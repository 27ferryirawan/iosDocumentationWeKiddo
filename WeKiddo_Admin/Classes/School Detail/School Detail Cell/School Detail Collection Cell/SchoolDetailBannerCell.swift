//
//  SchoolDetailBannerCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 09/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class SchoolDetailBannerCell: UICollectionViewCell {

    @IBOutlet weak var imageBanner: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configCell(index: Int) {
        var mediaArray = [SchoolDetailMediaModel]()
        for mediaObj in ACData.SCHOOLDETAILDATA.school_medias {
            if mediaObj.media_type_name == "Content Image" {
                mediaArray.append(mediaObj)
            }
        }
        imageBanner.sd_setImage(
            with: URL(string: (mediaArray[index].media_url)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
}
