//
//  ScoreNewCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 23/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class ScoreNewCell: UITableViewCell {
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var classRadiantLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var typeLabel: UIButton!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var scoreTypeView: UIButton!{
        didSet{
            self.scoreTypeView.layer.cornerRadius = 5
            self.scoreTypeView.layer.borderWidth = 1.0
            self.scoreTypeView.layer.borderColor = ACColor.MAIN.cgColor
            self.scoreTypeView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var viewBg: UIView! {
        didSet {
            self.viewBg.layer.cornerRadius = 7
            self.viewBg.layer.borderWidth = 1.0
            self.viewBg.layer.borderColor = UIColor.lightGray.cgColor
            self.viewBg.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var viewLeft: UIView! {
        didSet {
            self.viewLeft.layer.cornerRadius = self.viewLeft.frame.size.width / 2
            self.viewLeft.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var viewRight: UIView! {
        didSet {
            self.viewRight.layer.cornerRadius = self.viewRight.frame.size.width / 2
            self.viewRight.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var descriptionLbl: UILabel!{
        didSet{
            descriptionLbl.sizeToFit()
        }
    }
    var scoreObj: ScoreModel? {
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
        guard let obj = scoreObj else {
            return
        }
        subjectLabel.text = obj.subject_name
        typeLabel.setTitle(obj.score_type, for: .normal)
        dateLabel.text = obj.date
        scoreLabel.text = obj.score
        classRadiantLabel.text = obj.class_radiant
        descLabel.text = obj.score_description
    }
}
