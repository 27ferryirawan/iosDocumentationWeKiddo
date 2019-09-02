//
//  AddNewTaskAdminAssigneeCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 02/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol AddNewTaskAdminAssigneeCellDelegate: class {
    func groupSelectedAdmin(adminSelected: [String])
}

class AddNewTaskAdminAssigneeCell: UITableViewCell {

    @IBOutlet weak var groupCollection: UICollectionView!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var sectionButton: UIButton!
    @IBOutlet weak var sectionLabel: UIView!
    var selectedAdmin = [String]()
    var indexCurrent = 0
    var detailObj: AdminListModel? {
        didSet {
            cellConfig()
        }
    }
    weak var delegate: AddNewTaskAdminAssigneeCellDelegate?
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
        if selectedAdmin.contains(ACData.ADMINLISTDATA[indexCurrent].admin_member[indexPath.row].admin_id) {
            cell.buttonStatus.setImage(UIImage(named: "radio-on-button"), for: .normal)
        } else {
            cell.buttonStatus.setImage(UIImage(named: "circumference"), for: .normal)
        }
        cell.detailObj = ACData.ADMINLISTDATA[indexCurrent].admin_member[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedAdmin.count == 0 {
            selectedAdmin.append(ACData.ADMINLISTDATA[indexCurrent].admin_member[indexPath.row].admin_id)
            self.delegate?.groupSelectedAdmin(adminSelected: selectedAdmin)
            groupCollection.reloadData()
        } else {
            if selectedAdmin.contains(ACData.ADMINLISTDATA[indexCurrent].admin_member[indexPath.row].admin_id) {
                if let index = selectedAdmin.index(of: ACData.ADMINLISTDATA[indexCurrent].admin_member[indexPath.row].admin_id) {
                    selectedAdmin.remove(at: index)
                }
                self.delegate?.groupSelectedAdmin(adminSelected: selectedAdmin)
                groupCollection.reloadData()
            } else {
                selectedAdmin.append(ACData.ADMINLISTDATA[indexCurrent].admin_member[indexPath.row].admin_id)
                self.delegate?.groupSelectedAdmin(adminSelected: selectedAdmin)
                groupCollection.reloadData()
            }
        }
    }
}
