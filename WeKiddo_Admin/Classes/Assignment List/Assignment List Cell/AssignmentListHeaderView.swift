//
//  AssignmentListHeaderView.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 22/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit

class AssignmentListHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var classLabek: UILabel!

    var detailObj: CoordinatorAssignmentListPerSchool? {
        didSet {
            cellConfig()
        }
    }
    
    func cellConfig() {
        guard let obj = detailObj else { return }
        classLabek.text = obj.kelas
    }
    
}
