//
//  AgencyCell.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 02/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class AgencyCell: UITableViewCell {

    @IBOutlet weak var agencyList: UIView!{
        didSet{
            agencyList.setBorderShadow(color: UIColor.gray, shadowRadius: 3, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    @IBOutlet weak var agencyNameLbl: UILabel!
    @IBOutlet weak var agencyImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var agencyObjc: AgencyModel?{
        didSet{
            cellDataSet()
        }
    }
    
    func cellDataSet() {
        guard let agencyName = agencyObjc?.agency_name, let agencyImageUrl = agencyObjc?.agency_image else {
            return
        }
        agencyNameLbl.text = agencyName
        agencyImage.downloaded(from: agencyImageUrl)
    }
    
}
