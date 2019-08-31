//
//  AbsenceListCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 31/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol AbsenceListCellDelegate: class {
    func toDetailAbsence()
}

class AbsenceListCell: UITableViewCell {

    @IBOutlet weak var checkOutView: UIView! {
        didSet {
            checkOutView.layer.cornerRadius = 5.0
            checkOutView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var checkInView: UIView! {
        didSet {
            checkInView.layer.cornerRadius = 5.0
            checkInView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color: UIColor.lightGray, shadowRadius: 2.0, shadowOpactiy: 1.0, shadowOffsetWidth: 1, shadowOffsetHeight: 1)
        }
    }
    @IBOutlet weak var checkOutCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var checkInCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var checkOutCollectionView: UICollectionView!
    @IBOutlet weak var checkOutLabel: UILabel!
    @IBOutlet weak var checkInCollectionView: UICollectionView!
    @IBOutlet weak var checkInLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    var indexObj = 0
    weak var delegate: AbsenceListCellDelegate?
    var detailObj: AbsenceListModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        checkInCollectionView.register(UINib(nibName: "AbsenceListCollectionCell", bundle: nil), forCellWithReuseIdentifier: "absenceListCollectionCellID")
        checkOutCollectionView.register(UINib(nibName: "AbsenceListCollectionCell", bundle: nil), forCellWithReuseIdentifier: "absenceListCollectionCellID")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        classLabel.text = obj.school_class
        checkInCollectionView.reloadData()
        checkOutCollectionView.reloadData()
    }
}

extension AbsenceListCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == checkInCollectionView {
            return ACData.ABSENCELISTMODEL[indexObj].absence_checkin.count
        } else {
            return ACData.ABSENCELISTMODEL[indexObj].absence_checkout.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "absenceListCollectionCellID", for: indexPath) as? AbsenceListCollectionCell)!
        if collectionView == checkInCollectionView {
            cell.checkInObj = ACData.ABSENCELISTMODEL[indexObj].absence_checkin[indexPath.row]
        } else {
            cell.checkOutObj = ACData.ABSENCELISTMODEL[indexObj].absence_checkout[indexPath.row]
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == checkInCollectionView {
            ACRequest.POST_ABSENCE_DETAIL(userId: ACData.LOGINDATA.userID, childID: ACData.ABSENCELISTMODEL[indexObj].absence_checkin[indexPath.row].child_id, schoolID: ACData.DASHBOARDDATA.home_profile_school_id, yearID: ACData.DASHBOARDDATA.home_profile_year_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (data) in
                ACData.ABSENCEDETAILMODEL = data
                SVProgressHUD.dismiss()
                self.delegate?.toDetailAbsence()
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        } else {
            ACRequest.POST_ABSENCE_DETAIL(userId: ACData.LOGINDATA.userID, childID: ACData.ABSENCELISTMODEL[indexObj].absence_checkout[indexPath.row].child_id, schoolID: ACData.DASHBOARDDATA.home_profile_school_id, yearID: ACData.DASHBOARDDATA.home_profile_year_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (data) in
                ACData.ABSENCEDETAILMODEL = data
                SVProgressHUD.dismiss()
                self.delegate?.toDetailAbsence()
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        }
    }
}
