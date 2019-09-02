//
//  DetailTaskAdminGroupCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 02/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class DetailTaskAdminGroupCell: UITableViewCell {

    @IBOutlet weak var adminName: UILabel!
    @IBOutlet weak var adminCollection: UICollectionView!
    var currentIndex = 0
    var detailObj: DetailTaskAdminAssigneeModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        adminCollection.register(UINib(nibName: "DetailTaskAdminGroupCollectionCell", bundle: nil), forCellWithReuseIdentifier: "detailTaskAdminGroupCollectionCellID")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        adminName.text = obj.admin_pos_name
        adminCollection.reloadData()
    }
}

extension DetailTaskAdminGroupCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ACData.DETAILTASKADMINDATA.assigne_admin[currentIndex].member.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "detailTaskAdminGroupCollectionCellID", for: indexPath) as? DetailTaskAdminGroupCollectionCell)!
        cell.detailObj = ACData.DETAILTASKADMINDATA.assigne_admin[currentIndex].member[indexPath.row]
        return cell
    }
}
