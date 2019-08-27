//
//  NewsHeaderCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 03/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class NewsHeaderCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(index: Int) {
        contentImage.sd_setImage(
            with: URL(string: (ACData.PARENTNEWSCONTENT[index].news_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        contentLabel.text = ACData.PARENTNEWSCONTENT[index].news_title
    }
}
