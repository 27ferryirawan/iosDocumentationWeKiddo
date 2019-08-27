//
//  AddSubjectTeacherHeaderCell.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 14/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol AddSubjectTeacherHeaderCellDelegate: class {
    func titleFilled(withValue: String)
    func descFilled(withValue: String)
}

class AddSubjectTeacherHeaderCell: UITableViewCell, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var subjectDescription: UITextView!
    @IBOutlet weak var subjectTitle: UITextField!
    weak var delegate: AddSubjectTeacherHeaderCellDelegate?
    var detailObj: SubjectTeacherDetailModel? {
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
        subjectTitle.text = obj.chapter_name
        subjectDescription.text = obj.chapter_desc
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            self.delegate?.descFilled(withValue: text)
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Reason"
            textView.textColor = UIColor.lightGray
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        self.delegate?.descFilled(withValue: textView.text)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.delegate?.titleFilled(withValue: textField.text!)
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.titleFilled(withValue: textField.text!)
        textField.resignFirstResponder()
    }
}
