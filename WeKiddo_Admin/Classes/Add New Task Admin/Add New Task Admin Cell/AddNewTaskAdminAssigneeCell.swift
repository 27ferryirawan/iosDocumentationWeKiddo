//
//  AddNewTaskAdminAssigneeCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 02/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class AddNewTaskAdminAssigneeCell: UITableViewCell {

    @IBOutlet weak var groupCollection: UICollectionView!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var sectionButton: UIButton!
    @IBOutlet weak var sectionLabel: UIView!
    var indexCurrent = 0
    var detailObj: AdminListModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        sectionButton.addTarget(self, action: #selector(groupSelected), for: .touchUpInside)
        groupCollection.register(UINib(nibName: "AdminMemberCollectionCell", bundle: nil), forCellWithReuseIdentifier: "adminMemberCollectionCellID")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func groupSelected() {
        
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        groupName.text = obj.admin_pos_name
        groupCollection.reloadData()
    }
}

extension AddNewTaskAdminAssigneeCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ACData.ADMINLISTDATA[indexCurrent].admin_member.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "adminMemberCollectionCellID", for: indexPath) as? AdminMemberCollectionCell)!
        
        return cell
    }
}
