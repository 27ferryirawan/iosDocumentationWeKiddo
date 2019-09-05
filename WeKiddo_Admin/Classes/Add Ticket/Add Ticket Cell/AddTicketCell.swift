//
//  AddTicketCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 04/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

protocol AddTicketCellDelegate: class {
    func openImageAttachment()
    func saveNewTicket(withMediaArray: [TicketMediaModel])
    func titleFilledWithString(value: String)
    func typeFilledWithValue(value: String)
    func descriptionFilledWithValue(value: String)
}

class AddTicketCell: UITableViewCell {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var photoCollection: UICollectionView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var descText: UITextView!
    @IBOutlet weak var typePickerButton: UIButton!
    @IBOutlet weak var titleText: UITextField!
    var descriptionText = ""
    var placeholderLabel = UILabel()
    var mediaArray = [TicketMediaModel]()
    var ticketType = ["Bugs", "Enhancement"]
    weak var delegate: AddTicketCellDelegate?
    var detailObj: TicketMediaModel? {
        didSet {
            cellConfig()
        }
    }
    
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
    func cellConfig() {
//        guard let obj = detailObj else { return }
        print(mediaArray.count)
        photoCollection.reloadData()
    }
    @objc func showTypePicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Type -",
            rows: ticketType,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.typePickerButton.setTitle(value, for: .normal)
                self.delegate?.typeFilledWithValue(value: "\(indexes+1)")
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func addImageAttachment() {
        self.delegate?.openImageAttachment()
    }
    @objc func saveAction() {
        self.delegate?.saveNewTicket(withMediaArray: mediaArray)
    }
}

extension AddTicketCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "addTicketPhotoCollectionCellID", for: indexPath) as? AddTicketPhotoCollectionCell)!
        cell.detailObj = mediaArray[indexPath.row]
        return cell
    }
}

extension AddTicketCell: UITextViewDelegate, UITextFieldDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            descriptionText = text
            self.delegate?.descriptionFilledWithValue(value: text)
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
        self.delegate?.descriptionFilledWithValue(value: textView.text!)
        if textView.text.isEmpty {
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !descText.text.isEmpty
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.titleFilledWithString(value: textField.text!)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.delegate?.titleFilledWithString(value: textField.text!)
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.delegate?.titleFilledWithString(value: textField.text!)
        return true
    }
}
