//
//  AddScoreExamStudentScoreCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 24/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol AddScoreExamStudentScoreCellDelegate: class {
    func scoreFilled(withIndex: Int, withChildID: String, withScore: Int)
}

class AddScoreExamStudentScoreCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var studentScoreRadianText: UITextField!
    @IBOutlet weak var studetnLabelContania: UILabel!
    @IBOutlet weak var studentImage: UIImageView! {
        didSet {
            studentImage.layer.cornerRadius = 5.0
            studentImage.layer.masksToBounds = true
        }
    }
    var studentObj: ScoreStudent? {
        didSet {
            cellConfig()
        }
    }
    var index = 0
    weak var delegate: AddScoreExamStudentScoreCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = studentObj else { return }
        studentImage.sd_setImage(
            with: URL(string: (obj.childImage)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        studetnLabelContania.text = obj.childName
        studentScoreRadianText.text = "\(obj.score)"
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("index keberapa sekarang: \(index)")
        self.delegate?.scoreFilled(withIndex: index, withChildID: ACData.EXAMREMEDYSCORELISTDATA.student_list[index].child_id, withScore: Int(textField.text!)!)
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}
