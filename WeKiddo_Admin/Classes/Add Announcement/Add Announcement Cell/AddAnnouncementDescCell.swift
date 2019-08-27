//
//  AddAnnouncementDescCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 10/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol AddAnnouncementDescCellDelegate: class {
    func headerTextFilled(withString: String, withIndex: Int)
    func descTextFilled(withString: String, withIndex: Int)
}

class AddAnnouncementDescCell: UITableViewCell, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var descText: UITextView!
    @IBOutlet weak var headerText: UITextField!
    weak var delegate: AddAnnouncementDescCellDelegate?
    var index = 0
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.delegate?.headerTextFilled(withString: textField.text!, withIndex: index)
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            self.delegate?.descTextFilled(withString: textView.text!, withIndex: index)
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
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
        }
    }
}
