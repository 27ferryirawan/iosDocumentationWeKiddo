//
//  AddSubjectTeacherClassSelectedCell.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 14/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class AddSubjectTeacherClassSelectedCell: UITableViewCell {

    @IBOutlet weak var classLabel: UILabel!
    var selectedClassArray = [SubjectTeacherParamClassSelectedModel]()
    var currentIndex = 0
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig(atIndex: Int) {
        /* // Only use it when the data collection are heavy
            let placeData = UserDefaults.standard.data(forKey: "classSelected")
            let placeArray = try! JSONDecoder().decode([SubjectTeacherParamClassSelectedModel].self, from: placeData!)
            selectedClassArray = placeArray
         */
        classLabel.text = selectedClassArray[atIndex].school_class_name
    }
}
