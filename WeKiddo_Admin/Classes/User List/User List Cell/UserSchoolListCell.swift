//
//  UserSchoolListCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 06/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class UserSchoolListCell: UITableViewCell {

    @IBOutlet weak var teacherCollection: UICollectionView!
    @IBOutlet weak var homeRoomTeacherCollection: UICollectionView!
    @IBOutlet weak var adminCollection: UICollectionView!
    @IBOutlet weak var viewUser: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var schoolPicker: UIButton!
    var schoolArray = [String]()
    var adminArray = [UserListMemberModel]()
    var teacherArray = [UserListMemberModel]()
    var homeroomArray = [UserListMemberModel]()
    var detailObj: UserListModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        schoolPicker.addTarget(self, action: #selector(showSchoolPicker), for: .touchUpInside)
        adminCollection.register(UINib(nibName: "UserSchoolCollectionCell", bundle: nil), forCellWithReuseIdentifier: "userSchoolCollectionCellID")
        teacherCollection.register(UINib(nibName: "UserSchoolCollectionCell", bundle: nil), forCellWithReuseIdentifier: "userSchoolCollectionCellID")
        homeRoomTeacherCollection.register(UINib(nibName: "UserSchoolCollectionCell", bundle: nil), forCellWithReuseIdentifier: "userSchoolCollectionCellID")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        for item in ACData.USERSCHOOLLISTDATA {
            schoolArray.append(item.school_name)
        }
        for obc in ACData.USERLISTDATA {
            if obc.role_name == "Homeroom" {
                for itemObc in obc.members {
                    homeroomArray.append(itemObc)
                }
            } else if obc.role_name == "Admin" {
                for itemObc in obc.members {
                    adminArray.append(itemObc)
                }
            } else {
                for itemObj in obc.members {
                    teacherArray.append(itemObj)
                }
            }
        }
        adminCollection.reloadData()
        teacherCollection.reloadData()
        homeRoomTeacherCollection.reloadData()
    }
    @objc func showSchoolPicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Type -",
            rows: schoolArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.schoolPicker.setTitle(value, for: .normal)
//                self.delegate?.typeFilledWithValue(value: "\(indexes+1)")
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
}

extension UserSchoolListCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == adminCollection {
            return adminArray.count
        } else if collectionView == teacherCollection {
            return teacherArray.count
        } else {
            return homeroomArray.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == adminCollection {
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "userSchoolCollectionCellID", for: indexPath) as? UserSchoolCollectionCell)!
            cell.detailAdminObj = adminArray[indexPath.row]
            return cell
        } else if collectionView == teacherCollection {
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "userSchoolCollectionCellID", for: indexPath) as? UserSchoolCollectionCell)!
            cell.detailTeacherObj = teacherArray[indexPath.row]
            return cell
        } else {
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "userSchoolCollectionCellID", for: indexPath) as? UserSchoolCollectionCell)!
            cell.detailObj = homeroomArray[indexPath.row]
            return cell
        }
    }
}
