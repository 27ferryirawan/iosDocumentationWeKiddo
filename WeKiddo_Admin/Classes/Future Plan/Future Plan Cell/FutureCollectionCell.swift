//
//  FutureCollectionCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 14/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class FutureCollectionCell: UICollectionViewCell {

    @IBOutlet weak var contentTitle: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    var isAcademy = false
    var isCareer = false
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func config(index: Int){
        if isCareer {
            contentImage.sd_setImage(
                with: URL(string: "\(ACData.FUTUREPLANCAREERDATA[index].career_image)"),
                placeholderImage: UIImage(named: "WeKiddoLogo"),
                options: .refreshCached
            )
            contentTitle.text = ACData.FUTUREPLANCAREERDATA[index].career_name
        } else {
            if isAcademy {
                contentImage.sd_setImage(
                    with: URL(string: "\(ACData.FUTUREPLANACADEMYDATA[index].academic_image)"),
                    placeholderImage: UIImage(named: "WeKiddoLogo"),
                    options: .refreshCached
                )
                contentTitle.text = ACData.FUTUREPLANACADEMYDATA[index].academic_name
            } else {
                contentImage.sd_setImage(
                    with: URL(string: "\(ACData.FUTUREPLANTALENTDATA[index].talent_image)"),
                    placeholderImage: UIImage(named: "WeKiddoLogo"),
                    options: .refreshCached
                )
                contentTitle.text = ACData.FUTUREPLANTALENTDATA[index].talent_name
            }
        }
    }
}
