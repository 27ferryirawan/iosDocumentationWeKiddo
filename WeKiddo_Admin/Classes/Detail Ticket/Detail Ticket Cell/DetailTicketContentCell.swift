//
//  DetailTicketContentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 03/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class DetailTicketContentCell: UITableViewCell {

    var isFromSender = Bool()
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var textMessage: UITextField!
    @IBOutlet weak var sendMessageView: UIView! {
        didSet {
            sendMessageView.layer.borderWidth = 1.0
            sendMessageView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        }
    }
    @IBOutlet weak var chatCollection: UICollectionView!
    @IBOutlet weak var chatView: UIView! {
        didSet {
            chatView.layer.cornerRadius = 5.0
            chatView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
            chatView.layer.borderWidth = 1.0
            chatView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var solutionMessage: UILabel!
    @IBOutlet weak var solutionDate: UILabel!
    @IBOutlet weak var solutionView: UIView! {
        didSet {
            solutionView.layer.cornerRadius = 5.0
            solutionView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
            solutionView.layer.borderWidth = 1.0
            solutionView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var photoAlbumCollection: UICollectionView!
    @IBOutlet weak var detailContent: UILabel!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailDate: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    var detailObj: DetailTicketModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        sendMessageButton.addTarget(self, action: #selector(sendMessageAction), for: .touchUpInside)
        photoAlbumCollection.register(UINib(nibName: "AlbumCollectionCell", bundle: nil), forCellWithReuseIdentifier: "albumCollectionCellID")
        chatCollection.register(UINib(nibName: "SenderCollectionCell", bundle: nil), forCellWithReuseIdentifier: "senderCollectionCellID")
        chatCollection.register(UINib(nibName: "ReceiverCollectionCell", bundle: nil), forCellWithReuseIdentifier: "receiverCollectionCellID")
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func sendMessageAction() {
        
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        detailImage.image = UIImage(named: "WeKiddoLogo")
        detailDate.text = "\(obj.ticket_id) | \(getMonth(time: obj.created_at))"
        detailTitle.text = obj.title
        detailContent.text = obj.desc
        solutionDate.text = "Admin | \(getMonth(time: obj.response_time))"
        solutionMessage.text = obj.response_msg
        chatCollection.reloadData()
    }
}

extension DetailTicketContentCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == photoAlbumCollection {
            return 3
        } else {
            return ACData.DETAILTICKETDATA.chat.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == photoAlbumCollection {
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "albumCollectionCellID", for: indexPath) as? AlbumCollectionCell)!
            return cell
        } else {
            if ACData.LOGINDATA.userID == ACData.DETAILTICKETDATA.chat[indexPath.row].sender_id {
                let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "senderCollectionCellID", for: indexPath) as? SenderCollectionCell)!
                cell.detailObj = ACData.DETAILTICKETDATA.chat[indexPath.row]
                return cell
            } else {
                let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "receiverCollectionCellID", for: indexPath) as? ReceiverCollectionCell)!
                cell.detailObj = ACData.DETAILTICKETDATA.chat[indexPath.row]
                return cell
            }
        }
    }
}

extension DetailTicketContentCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension DetailTicketContentCell {
    func getMonth(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        // then convert date to string again
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "dd MMM yyyy - HH:mm"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
