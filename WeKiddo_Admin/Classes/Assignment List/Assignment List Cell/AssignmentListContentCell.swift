//
//  AssignmentListContentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 21/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol AssignmentListContentCellDelegate: class {
    func toDetailWorksheet()
}

class AssignmentListContentCell: UITableViewCell {

    weak var delegate: AssignmentListContentCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func detailButton(_ sender: UIButton) {
        self.delegate?.toDetailWorksheet()
    }
    
}
