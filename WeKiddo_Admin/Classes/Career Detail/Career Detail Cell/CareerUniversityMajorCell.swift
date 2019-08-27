//
//  CareerUniversityMajorCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 23/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class CareerUniversityMajorCell: UICollectionViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func config(index: Int) {
        contentImage.sd_setImage(
            with: URL(string: ACData.CAREERDETAILDATA.universityMajor[index].major_image),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        contentLabel.text = ACData.CAREERDETAILDATA.universityMajor[index].major_name
    }
}
