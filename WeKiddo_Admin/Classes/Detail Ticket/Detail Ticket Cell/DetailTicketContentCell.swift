//
//  DetailTicketContentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 03/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

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
}

extension DetailTicketContentCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == photoAlbumCollection {
            return 3
        } else {
            return 6
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == photoAlbumCollection {
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "albumCollectionCellID", for: indexPath) as? AlbumCollectionCell)!
            return cell
        } else {
            if isFromSender {
                let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "senderCollectionCellID", for: indexPath) as? SenderCollectionCell)!
                return cell
            } else {
                let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "receiverCollectionCellID", for: indexPath) as? ReceiverCollectionCell)!
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
