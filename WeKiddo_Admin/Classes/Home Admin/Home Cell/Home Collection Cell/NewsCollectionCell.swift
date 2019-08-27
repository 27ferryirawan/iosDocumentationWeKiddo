//
//  NewsCollectionCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 18/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class NewsCollectionCell: UICollectionViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(index: Int) {
        newsImage.sd_setImage(
            with: URL(string: (ACData.DASHBOARDDATA.dashboardNews[index].news_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        newsContent.text = ACData.DASHBOARDDATA.dashboardNews[index].news_title
    }
}
