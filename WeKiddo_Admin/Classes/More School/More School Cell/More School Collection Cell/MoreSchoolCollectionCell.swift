//
//  MoreSchoolCollectionCell.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 03/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class MoreSchoolCollectionCell: UICollectionViewCell {

    
    
    @IBOutlet weak var collectionList: UIView!{
        didSet{
            collectionList.layer.borderWidth = 1
            collectionList.layer.borderColor = ACColor.GREY_CELL.cgColor
        }
    }
    @IBOutlet weak var schoolImage: UIImageView!
    @IBOutlet weak var schoolName: UILabel!
    var schoolId : String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(index: Int) {
        schoolImage.sd_setImage(
            with: URL(string: (ACData.LOGININFODATA[index].school_logo)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        schoolName.text = ACData.LOGININFODATA[index].school_name
    }
    
    func getSchoolId(index : Int) -> String {
        schoolId = ACData.LOGININFODATA[index].school_id
        return schoolId
    }

}
