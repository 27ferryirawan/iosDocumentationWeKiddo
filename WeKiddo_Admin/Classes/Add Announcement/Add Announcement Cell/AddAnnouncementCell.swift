//
//  AddAnnouncementCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 17/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

protocol AddAnnouncementCellDelegate: class {
    func titleHeaderFilled(withString: String)
    func publishDateSelected(withDate: String)
    func endDateSelected(withDate: String)
    func descFilled(withString: String)
    func showBannerPicker()
}

class AddAnnouncementCell: UITableViewCell, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var descHeaderText: UITextView!
    @IBOutlet weak var endDateButton: UIButton!
    @IBOutlet weak var publishDateButton: UIButton!
    @IBOutlet weak var bannerPhotoCollectiob: UICollectionView!
    @IBOutlet weak var bannerPhotoButton: UIButton! {
        didSet {
            bannerPhotoButton.layer.cornerRadius = 5.0
            bannerPhotoButton.layer.masksToBounds = true
            bannerPhotoButton.layer.borderWidth = 0.5
            bannerPhotoButton.layer.borderColor = ACColor.MAIN.cgColor
        }
    }
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    var titleHeader = ""
    weak var delegate: AddAnnouncementCellDelegate?
    var detailObj: AttachmentBannerModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        publishDateButton.addTarget(self, action: #selector(showPublishDatePicker), for: .touchUpInside)
        endDateButton.addTarget(self, action: #selector(showEndDatePicker), for: .touchUpInside)
        dateLabel.text = "Date : \(getMonth())"
        titleText.text = titleHeader
        bannerPhotoButton.addTarget(self, action: #selector(showBannerImagePicker), for: .touchUpInside)
        bannerPhotoCollectiob.register(UINib(nibName: "BannerCollectionCell", bundle: nil), forCellWithReuseIdentifier: "bannerCollectionCellID")
        DispatchQueue.main.async {
            self.bannerPhotoCollectiob.reloadData()
            self.bannerPhotoCollectiob.collectionViewLayout.invalidateLayout()
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
//        guard let obj = detailObj else { return }
//        bannerPhotoCollectiob.reloadData()
    }
    @objc func showPublishDatePicker() {
        ActionSheetDatePicker.show(
            withTitle: "- Select Date -",
            datePickerMode: .date,
            selectedDate: Date(),
            doneBlock: { picker, selectedDate, origin in
                let dateFormatter = DateFormatter()
                let dateFormatter2 = DateFormatter()
                let locale = Locale(identifier: "id")
                dateFormatter.dateFormat = "dd / MM / yyyy"
                dateFormatter2.dateFormat = "yyyy-MM-dd"
                dateFormatter.locale = locale
                dateFormatter2.locale = locale
                let selectedDates = dateFormatter.string(from: selectedDate as! Date)
                let choosenDate = dateFormatter2.string(from: selectedDate as! Date)
                self.publishDateButton.setTitle(selectedDates, for: .normal)
                self.delegate?.publishDateSelected(withDate: choosenDate)
        }, cancel: nil, origin: self)
    }
    @objc func showEndDatePicker() {
        ActionSheetDatePicker.show(
            withTitle: "- Select Date -",
            datePickerMode: .date,
            selectedDate: Date(),
            doneBlock: { picker, selectedDate, origin in
                let dateFormatter = DateFormatter()
                let dateFormatter2 = DateFormatter()
                let locale = Locale(identifier: "id")
                dateFormatter.dateFormat = "dd / MM / yyyy"
                dateFormatter2.dateFormat = "yyyy-MM-dd"
                dateFormatter.locale = locale
                dateFormatter2.locale = locale
                let selectedDates = dateFormatter.string(from: selectedDate as! Date)
                let choosenDate = dateFormatter2.string(from: selectedDate as! Date)
                self.endDateButton.setTitle(selectedDates, for: .normal)
                self.delegate?.endDateSelected(withDate: choosenDate)
        }, cancel: nil, origin: self)
    }
    @objc func showBannerImagePicker() {
        self.delegate?.showBannerPicker()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.delegate?.titleHeaderFilled(withString: textField.text!)
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            self.delegate?.descFilled(withString: textView.text!)
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

extension AddAnnouncementCell {
    func getMonth() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        let result = formatter.string(from: date)
        return result
    }
}

extension AddAnnouncementCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ACData.ATTACHMENTBANNERDATA.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCollectionCellID", for: indexPath) as? BannerCollectionCell)!
        cell.contentObj = ACData.ATTACHMENTBANNERDATA[indexPath.row]
        return cell
    }
}
