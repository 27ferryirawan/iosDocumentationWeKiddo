//
//  AbsenceListCollectionCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 31/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class AbsenceListCollectionCell: UICollectionViewCell {

    @IBOutlet weak var contentName: UILabel!
    @IBOutlet weak var contentImage: UIImageView! {
        didSet {
            contentImage.layer.cornerRadius = contentImage.frame.size.width / 2
            contentImage.layer.masksToBounds = true
        }
    }
    var checkInObj: AbsenceListCheckInModel? {
        didSet {
            cellConfigCheckin()
        }
    }
    var checkOutObj: AbsenceListCheckOutModel? {
        didSet {
            cellConfigCheckout()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func cellConfigCheckin() {
        guard let obj = checkInObj else { return }
        contentImage.sd_setImage(
            with: URL(string: (obj.child_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        contentName.text = obj.child_name
    }
    func cellConfigCheckout() {
        guard let obj = checkOutObj else { return }
        contentImage.sd_setImage(
            with: URL(string: (obj.child_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        contentName.text = obj.child_name
    }
}
