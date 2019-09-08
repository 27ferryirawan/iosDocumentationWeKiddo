//
//  SOPDetailCell.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 08/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class SOPDetailCell: UITableViewCell {
    
    @IBOutlet weak var sopImage: UIImageView!
    @IBOutlet weak var sopTitle: UILabel!
    @IBOutlet weak var sopDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellDataSet()
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellDataSet(){
        guard let obj = ACData.SOPDETAILDATA else{ return }
        sopTitle.text = obj.sop_title
        sopDescription.text = obj.sop_content
        sopDescription.sizeToFit()
        self.sopImage.sd_setImage(
            with: URL(string: (obj.sop_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
}
