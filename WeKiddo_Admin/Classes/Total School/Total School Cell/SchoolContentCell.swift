//
//  SchoolContentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 21/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class SchoolContentCell: UICollectionViewCell {

    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var schoolImage: UIImageView!
    
    var detailObj: DashboardCoordinatorSchoolListDataModel? {
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
        self.schoolImage.sd_setImage(
            with: URL(string: (obj.school_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        schoolName.text = obj.school_name
    }

}
