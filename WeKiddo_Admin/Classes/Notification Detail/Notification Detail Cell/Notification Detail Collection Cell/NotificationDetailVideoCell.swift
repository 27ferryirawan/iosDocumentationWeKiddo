//
//  NotificationDetailVideoCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 20/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class NotificationDetailVideoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageContent: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    var detailObj: ApprovalDetailMediaModel? {
        didSet {
            configCell()
        }
    }
    func configCell() {
        guard let obj = detailObj else { return }
        //        var mediaArray = [ApprovalDetailMediaModel]()
        //        for mediaObj in ACData.APPROVALDETAILDATA.medias {
        //            if mediaObj.media_type_id == "MT1" {
        //                mediaArray.append(mediaObj)
        //            }
        //        }
        imageContent.sd_setImage(
            with: URL(string: obj.url),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
}
