//
//  ApprovalDetailFooterCell.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 01/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol ApprovalDetailFooterCellDelegate: class {
    func previewImage(withImageURL: String)
    func playVideo(withURL: String)
    func uploadFile()
}

class ApprovalDetailFooterCell: UITableViewCell {
    
    @IBOutlet weak var uploadGalleryButton: UIButton!
    @IBOutlet weak var videoCollection: UICollectionView!
    @IBOutlet weak var galleryCollection: UICollectionView!
    var detailObj: ApprovalDetailModel? {
        didSet {
            cellConfig()
        }
    }
    @IBOutlet weak var galleryLbl: UILabel!{
        didSet{
            galleryLbl.text = "Gallery"
            galleryLbl.textColor = ACColor.MAIN
        }
    }
    
    var mediaArray = [ApprovalDetailMediaModel]()
    var videoArray = [ApprovalDetailMediaModel]()
    weak var delegate: ApprovalDetailFooterCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        galleryCollection.dataSource = self
        galleryCollection.delegate = self
        videoCollection.dataSource = self
        videoCollection.delegate = self
        galleryCollection.register(UINib(nibName: "NotificationDetailImageGalleryCell", bundle: nil), forCellWithReuseIdentifier: "notificationImageCell")
        videoCollection.register(UINib(nibName: "NotificationDetailVideoCell", bundle: nil), forCellWithReuseIdentifier: "notificationVideoCell")
        uploadGalleryButton.addTarget(self, action: #selector(uploadAction), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {

    }
    @objc func uploadAction() {
        self.delegate?.uploadFile()
    }
}

extension ApprovalDetailFooterCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == galleryCollection {
            return mediaArray.count
        } else {
            return videoArray.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.width)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == galleryCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "notificationImageCell", for: indexPath as IndexPath) as! NotificationDetailImageGalleryCell
            cell.detailObj = mediaArray[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "notificationVideoCell", for: indexPath as IndexPath) as! NotificationDetailVideoCell
            cell.detailObj = videoArray[indexPath.row]
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == galleryCollection {
            self.delegate?.previewImage(withImageURL: mediaArray[indexPath.row].url)
        } else {
            self.delegate?.playVideo(withURL: videoArray[indexPath.row].url)
        }
    }
}
