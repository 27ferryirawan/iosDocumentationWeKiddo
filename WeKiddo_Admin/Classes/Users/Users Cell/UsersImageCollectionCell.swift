//
//  UsersImageCollectionCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 07/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class UsersImageCollectionCell: UICollectionViewCell {

    @IBOutlet weak var contentNameLabel: UILabel!
    @IBOutlet weak var contentImage: UIImageView!{
        didSet{
            contentImage.layer.cornerRadius = contentImage.frame.size.width/2
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
