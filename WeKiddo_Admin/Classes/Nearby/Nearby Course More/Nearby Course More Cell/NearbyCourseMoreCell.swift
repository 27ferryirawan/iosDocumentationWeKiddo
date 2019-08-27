//
//  NearbyCourseMoreCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 29/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class NearbyCourseMoreCell: UICollectionViewCell {

    @IBOutlet weak var contentDistanceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config(index: Int) {
//        contentDistanceLabel.text = "\(ACData.NEARBYCOURSEMOREDATA[0].course_location)Km"
//        contentLabel.text = ACData.NEARBYCOURSEMOREDATA[0].course_name
//        contentImage.sd_setImage(
//            with: URL(string: "\(ACData.NEARBYCOURSEMOREDATA[0].course_image)"),
//            placeholderImage: UIImage(named: "WeKiddoLogo"),
//            options: .refreshCached
//        )
    }
}
