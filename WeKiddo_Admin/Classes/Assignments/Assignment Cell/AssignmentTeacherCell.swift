//
//  AssignmentTeacherCell.swift
//  WeKiddo_Admin
//
//  Created by Yosua Hoo on 30/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class AssignmentTeacherCell: UITableViewCell {

    
    @IBOutlet weak var containerView: UIView!{
        didSet{
            containerView.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var lbTeacher: UILabel!
    
    var objTeacher: AssignmentTeacherContentModel? {
        didSet {
            cellDataSet()
        }
    }
    
    func cellDataSet() {
        lbTeacher.text = objTeacher?.teacher_name ?? ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
