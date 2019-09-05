//
//  AddTicketCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 04/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class AddTicketCell: UITableViewCell {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var photoCollection: UICollectionView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var descText: UITextView!
    @IBOutlet weak var typePickerButton: UIButton!
    @IBOutlet weak var titleText: UITextField!
    var descriptionText = ""
    var placeholderLabel = UILabel()
    var ticketType = ["Bugs", "Enhancement"]
    override func awakeFromNib() {
        super.awakeFromNib()
        typePickerButton.addTarget(self, action: #selector(showTypePicker), for: .touchUpInside)
        addPhotoButton.addTarget(self, action: #selector(addImageAttachment), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        photoCollection.register(UINib(nibName: "AddTicketPhotoCollectionCell", bundle: nil), forCellWithReuseIdentifier: "addTicketPhotoCollectionCellID")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func showTypePicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Type -",
            rows: ticketType,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.typePickerButton.setTitle(value, for: .normal)
//              self.delegate?.typeSelected(type: value)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func addImageAttachment() {
        
    }
    @objc func saveAction() {
        
    }
}

extension AddTicketCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "addTicketPhotoCollectionCellID", for: indexPath) as? AddTicketPhotoCollectionCell)!
        
        return cell
    }
}

extension AddTicketCell: UITextViewDelegate, UITextFieldDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            descriptionText = text
//            self.delegate?.descFilled(withDesc: text)
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
        descriptionText = textView.text!
//        self.delegate?.descFilled(withDesc: textView.text!)
        if textView.text.isEmpty {
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !descText.text.isEmpty
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
