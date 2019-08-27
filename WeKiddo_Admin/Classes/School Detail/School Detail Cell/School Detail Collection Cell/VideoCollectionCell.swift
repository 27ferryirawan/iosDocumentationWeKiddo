//
//  VideoCollectionCell.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 02/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class VideoCollectionCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configCell(index: Int) {
        var mediaArray = [SchoolDetailMediaModel]()
        for mediaObj in ACData.SCHOOLDETAILDATA.school_medias {
            if mediaObj.media_type_name == "Video" {
                mediaArray.append(mediaObj)
            }
        }
        thumbnailImage.sd_setImage(
            with: URL(string: (mediaArray[index].thumbnail)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
}
