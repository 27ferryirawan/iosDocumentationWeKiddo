//
//  ExerciseListContentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 22/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol ExerciseListContentCellDelegate: class {
    func toDetailExercise()
}

class ExerciseListContentCell: UITableViewCell {

    @IBOutlet weak var detailButton: UIButton!
    
    weak var delegate: ExerciseListContentCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func detailAction(_ sender: UIButton) {
        self.delegate?.toDetailExercise()
    }
    
}
