//
//  TotalSchoolContentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 21/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol TotalSchoolContentCellDelegate: class {
    func toSchoolDashboard()
}

class TotalSchoolContentCell: UITableViewCell {
    
    @IBOutlet weak var schoolCollection: UICollectionView!
    
    var indexSection = 0
    var date = ""
    
    weak var delegate: TotalSchoolContentCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        schoolCollection.register(UINib(nibName: "SchoolContentCell", bundle: nil), forCellWithReuseIdentifier: "schoolContentCellID")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fetchDetailSchoolDashbaord() {
        guard let schoolIndexZero = ACData.LOGINDATA.dashboardSchoolMenu[0].school_id, let yearIndexZero = ACData.LOGINDATA.dashboardSchoolMenu[0].year_id else {
            return
        }
        ACRequest.POST_DASHBOARD_DETAIL_SCHOOL(userId: ACData.LOGINDATA.userID, date: date, yearID: yearIndexZero, schoolID: schoolIndexZero, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (result) in
            SVProgressHUD.dismiss()
            ACData.DASHBOARDSCHOOLLISTDETAILDATA = result
            self.delegate?.toSchoolDashboard()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}

extension TotalSchoolContentCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ACData.DASHBOARDCOORDINATORSCHOOLLISTDATA[indexSection].list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "schoolContentCellID", for: indexPath) as? SchoolContentCell)!
        cell.detailObj = ACData.DASHBOARDCOORDINATORSCHOOLLISTDATA[indexSection].list[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        fetchDetailSchoolDashbaord()
    }
}
