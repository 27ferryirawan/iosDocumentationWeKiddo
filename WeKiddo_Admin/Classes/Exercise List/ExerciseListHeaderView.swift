//
//  ExerciseListHeaderView.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 22/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit

class ExerciseListHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.borderColor = UIColor.white.cgColor
            bgView.layer.borderWidth = 1.0
        }
    }
    
    var detailObj: CoordinatorExerciseSchoolCreateListModel? {
        didSet {
            cellConfig()
        }
    }
    
    func cellConfig() {
        guard let obj = detailObj else { return }
        sectionLabel.text = obj.subject_name
    }

}
