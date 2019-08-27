//
//  ExamScoreStudentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 24/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

protocol ExamScoreStudentCellDelegate: class {
    func scoreFilled(withIndex: Int, withChildID: String, withScore: Int)
}

class ExamScoreStudentCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var studentScorePassGradeLabel: UILabel!
    @IBOutlet weak var studentScoreRadianLabel: UITextField!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentImage: UIImageView!
    weak var delegate: ExamScoreStudentCellDelegate?
    var index = 0
    var detailObj: ScoreStudent? {
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
        guard let obj = detailObj else { return }
        studentImage.sd_setImage(
            with: URL(string: (obj.childImage)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        studentName.text = obj.childName
        studentScorePassGradeLabel.text = "\(obj.score)"
        studentScoreRadianLabel.text = "\(obj.examScore)"
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let obj = detailObj else { return false }
        guard let score = Int(textField.text!) else {
            return false
        }
        self.delegate?.scoreFilled(withIndex: index, withChildID: obj.childID, withScore: score)
        textField.resignFirstResponder()
        return true
    }
}
