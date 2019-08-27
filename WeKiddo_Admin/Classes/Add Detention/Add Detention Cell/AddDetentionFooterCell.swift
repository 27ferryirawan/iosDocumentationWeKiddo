//
//  AddDetentionFooterCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 09/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol AddDetentionFooterCellDelegate: class {
    func reasonFilled(withReason: String)
    func detentionClicked()
    func textViewPlaceHolder(textView: UITextView)
}

class AddDetentionFooterCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var addDetentionButto: UIButton!
    @IBOutlet weak var reasonText: UITextView!
    weak var delegate: AddDetentionFooterCellDelegate?
    let placeholder = "Reason"
    override func awakeFromNib() {
        super.awakeFromNib()
        addDetentionButto.addTarget(self, action: #selector(addDetention), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func textViewSetup(){
        reasonText.delegate = self
        reasonText.text = placeholder
        reasonText.textColor = UIColor.lightGray
        reasonText.selectedTextRange = reasonText.textRange(from: reasonText.beginningOfDocument, to: reasonText.beginningOfDocument)
    }
    @objc func addDetention() {
        self.delegate?.detentionClicked()
    }
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if (text == "\n") {
//            textView.resignFirstResponder()
//            return false
//        }
//        self.delegate?.reasonFilled(withReason: textView.text!)
//        return true
//    }
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView.textColor == UIColor.lightGray {
//            textView.text = nil
//            textView.textColor = UIColor.black
//        }
//    }
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text.isEmpty {
//            textView.text = "Reason"
//            textView.textColor = UIColor.lightGray
//        }
//    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText: NSString = textView.text as NSString
        let updatedText = currentText.replacingCharacters(in: range, with:text)
        
        if updatedText.isEmpty {
            textView.text = placeholder
            textView.textColor = UIColor.lightGray
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            return false
        }
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        self.delegate?.reasonFilled(withReason: textView.text!)
        return true
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        self.delegate?.textViewPlaceHolder(textView: textView)
    }
}
