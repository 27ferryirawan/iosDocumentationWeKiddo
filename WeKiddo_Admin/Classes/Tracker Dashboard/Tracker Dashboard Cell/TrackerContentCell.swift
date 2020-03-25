//
//  TrackerContentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 21/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol TrackerContentCellDelegate: class {
    func toDetailPage(withIndex: Int)
}

class TrackerContentCell: UITableViewCell {

    @IBOutlet weak var labelRight: UILabel!
    @IBOutlet weak var totalRight: UILabel!
    @IBOutlet weak var labelLeft: UILabel!
    @IBOutlet weak var totalLeft: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var worksheetView: UIView! {
        didSet {
            worksheetView.layer.cornerRadius = worksheetView.frame.size.width / 2
            worksheetView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var rightView: UIView! {
        didSet {
            rightView.layer.borderColor = UIColor.lightGray.cgColor
            rightView.layer.borderWidth = 1.0
            rightView.layer.cornerRadius = 5.0
            rightView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var averageView: UIView! {
        didSet {
            averageView.layer.cornerRadius = averageView.frame.size.width / 2
            averageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var leftView: UIView! {
        didSet {
            leftView.layer.borderColor = UIColor.lightGray.cgColor
            leftView.layer.borderWidth = 1.0
            leftView.layer.cornerRadius = 5.0
            leftView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.borderColor = UIColor.lightGray.cgColor
            bgView.layer.borderWidth = 1.0
            bgView.layer.cornerRadius = 5.0
            bgView.layer.masksToBounds = true
        }
    }
    
    weak var delegate: TrackerContentCellDelegate?
    var index = 0
    
    var detailObj: DashboardCoordinatorModel? {
        didSet {
            cellConfig()
        }
    }
    
    var detailSchoolObj: DashboardDetailSchoolModel? {
        didSet {
            cellConfigSchool()
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
    @IBAction func toDetailAction(_ sender: Any) {
        self.delegate?.toDetailPage(withIndex: index)
    }
    
    func cellConfigSchool() {
        guard let obj = detailSchoolObj else { return }
        if index == 1 {
            sectionLabel.text = "Assignment"
            totalLeft.text = "\(obj.assignment_average_assignment)"
            labelLeft.text = "Average Assignment by Student"
            totalRight.text = "\(obj.assignment_worksheet_submission)%"
            labelRight.text = "Worksheet Submission"
        } else if index == 2 {
            sectionLabel.text = "E Book"
            totalLeft.text = "\(obj.ebook_total_school_upload)%"
            labelLeft.text = "Total School Upload"
            totalRight.text = "\(obj.ebook_total_school_download)"
            labelRight.text = "Total Student Download"
        } else {
            sectionLabel.text = "Exercise"
            totalLeft.text = "\(obj.exercise_total_created_exercise)%"
            labelLeft.text = "Total Created Exercise"
            totalRight.text = "\(obj.exercise_total_student_do_exercsie)"
            labelRight.text = "Total Student Do Exercise"
        }
    }
    
    func cellConfig() {
        guard let obj = detailObj else { return }
        if index == 1 {
            sectionLabel.text = "Assignment"
            totalLeft.text = "\(obj.assignment_average_assignment)"
            labelLeft.text = "Average Assignment (by Student)"
            totalRight.text = "\(obj.assignment_worksheet_submission_percent)%"
            labelRight.text = "Worksheet Submission"
        } else if index == 2 {
            sectionLabel.text = "E Book"
            totalLeft.text = "\(obj.ebook_school_with_ebook_percent)%"
            labelLeft.text = "School With EBook"
            totalRight.text = "\(obj.ebook_total_student_download)"
            labelRight.text = "Total Student Download"
        } else {
            sectionLabel.text = "Exercise"
            totalLeft.text = "\(obj.exercise_school_created_exercise_percent)%"
            labelLeft.text = "School Created Exercise"
            totalRight.text = "\(obj.exercise_total_student_do_exercise)"
            labelRight.text = "Total Student Do Exercise"
        }
    }
    
}
