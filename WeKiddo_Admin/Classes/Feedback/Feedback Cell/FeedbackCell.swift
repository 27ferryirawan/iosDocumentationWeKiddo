//
//  FeedbackCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 31/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import UITextView_Placeholder

protocol FeedbackCellDelegate: class {
    func openAttachmentBanner()
    func feedbackDescFilled(withString: String)
}

class FeedbackCell: UITableViewCell {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var attachmentCollection: UICollectionView!
    @IBOutlet weak var mediaButton: UIButton!
    @IBOutlet weak var descText: UITextView!
    var feedbackDesc = ""
    var placeholderLabel = UILabel()
    weak var delegate: FeedbackCellDelegate?
    var detailObj: AttachmentImageMediaModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        submitButton.addTarget(self, action: #selector(submitFeedback), for: .touchUpInside)
        mediaButton.addTarget(self, action: #selector(showAttachmentPicker), for: .touchUpInside)
        attachmentCollection.register(UINib(nibName: "ImageMediaCollectionCell", bundle: nil), forCellWithReuseIdentifier: "imageMediaCollectionCellID")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func showAttachmentPicker() {
        self.delegate?.openAttachmentBanner()
    }
    func cellConfig() {
        if feedbackDesc == "" {
            descText.placeholderColor = UIColor.lightGray // optional
        } else {
            descText.text = feedbackDesc
        }
    }
    @objc func submitFeedback() {
        if descText.text == "" || ACData.ATTACHMENTIMAGEMEDIADATA.count == 0 {
            ACAlert.show(message: "Please at least fill description or have attachment file")
        } else {
            var imageOn = "["
            
            if ACData.ATTACHMENTIMAGEMEDIADATA.count != 0 {
                var i = 0
                for data in ACData.ATTACHMENTIMAGEMEDIADATA {
                    if i > 0 {
                        imageOn += ","
                    }
                    imageOn += "{"
                    imageOn += "\"id\":\"\(data.media_id)\""
                    imageOn += "}"
                    
                    i += 1
                }
            }
            

            imageOn += "]"
            
            let newImageAddOn = imageOn.replacingOccurrences(of: "\\", with: "")
            let jsonImageData = newImageAddOn.data(using: .utf8)!
            let jsonImage = try! JSONSerialization.jsonObject(with: jsonImageData, options: .allowFragments)
            
            let parameters: Parameters = [
                "user_id":ACData.LOGINDATA.userID,
                "feedback_id":"",
                "description":feedbackDesc,
                "media_list":jsonImage
            ]
            
            ACRequest.POST_FEEDBACK(params: parameters, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: status)
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        }
    }
}

extension FeedbackCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            feedbackDesc = text
            self.delegate?.feedbackDescFilled(withString: text)
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
        feedbackDesc = textView.text!
        self.delegate?.feedbackDescFilled(withString: textView.text!)
        if textView.text.isEmpty {
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !descText.text.isEmpty
    }
}

extension FeedbackCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ACData.ATTACHMENTIMAGEMEDIADATA.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "imageMediaCollectionCellID", for: indexPath) as? ImageMediaCollectionCell)!
        cell.contentObj = ACData.ATTACHMENTIMAGEMEDIADATA[indexPath.row]
        return cell
    }
}
