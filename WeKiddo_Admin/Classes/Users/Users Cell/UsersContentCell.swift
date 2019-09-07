//
//  UsersContentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 07/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol UsersContentCellDelegate: class {
    func toDetail()
}

class UsersContentCell: UITableViewCell {

    @IBOutlet weak var adminCollection: UICollectionView! {
        didSet {
            adminCollection.layer.cornerRadius = 5.0
            adminCollection.layer.borderWidth = 1.0
            adminCollection.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        }
    }
    @IBOutlet weak var adminROle: UILabel!
    var adminArray = 0
    var index = 0
    var detailObj: UsersListsModel? {
        didSet {
            cellConfig()
        }
    }
    
    weak var delegate: UsersContentCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        adminCollection.register(UINib(nibName: "UsersImageCollectionCell", bundle: nil), forCellWithReuseIdentifier: "usersImageCollectionCellID")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        adminROle.text = obj.admin_pos_name
        adminArray = obj.members.count
        adminCollection.reloadData()
    }
}

extension UsersContentCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adminArray
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "usersImageCollectionCellID", for: indexPath) as? UsersImageCollectionCell)!
        cell.contentImage.sd_setImage(
            with: URL(string: (ACData.USERSLISTSDATA[index].members[indexPath.row].admin_photo)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        cell.contentNameLabel.text = ACData.USERSLISTSDATA[index].members[indexPath.row].name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ACRequest.POST_USERS_DETAIL(userId: ACData.LOGINDATA.userID, adminID: ACData.USERSLISTSDATA[index].members[indexPath.row].admin_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (result) in
            ACData.USERSDETAILDATA = result
            SVProgressHUD.dismiss()
            self.delegate?.toDetail()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}
