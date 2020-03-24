//
//  StudentDoExerciseContentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 22/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class StudentDoExerciseContentCell: UITableViewCell {

    @IBOutlet weak var subjectName: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var childName: UILabel!
    @IBOutlet weak var childImage: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    var detailObj: CoordinatorExerciseStudentDoExerciseListModel? {
        didSet {
            cellConfig()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellConfig() {
        guard let obj = detailObj else { return }
        self.childImage.sd_setImage(
            with: URL(string: (obj.child_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        childName.text = "\(obj.child_name)\nNIK \(obj.child_nis)\n\(obj.school_class)"
        subjectName.text = obj.exercise_name
        scoreLabel.text = "Score \(obj.score)"
    }
    
}
