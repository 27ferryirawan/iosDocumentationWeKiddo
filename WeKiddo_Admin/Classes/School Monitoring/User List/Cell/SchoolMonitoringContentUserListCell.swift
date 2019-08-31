//
//  SchoolMonitoringContentUserListCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 31/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class SchoolMonitoringContentUserListCell: UITableViewCell {

    @IBOutlet weak var contentDay: UILabel!
    @IBOutlet weak var contentDate: UILabel!
    @IBOutlet weak var contentName: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    var detailStudentObj: SchoolMonitoringModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        
    }
}
