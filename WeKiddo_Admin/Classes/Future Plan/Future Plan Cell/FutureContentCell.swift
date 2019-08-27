//
//  FutureContentCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 14/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol FutureContentDelegate: class {
    func goToCareerDetail()
}

class FutureContentCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var isAcademic = false
    var isCareer = false
    
    weak var delegate: FutureContentDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "FutureCollectionCell", bundle: nil), forCellWithReuseIdentifier: "futureCollectionCell")
    }
    func config() {
        collectionView.reloadData()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func fetchCareerByAcademic(index: String) {
        ACData.FUTUREPLANCAREERDATA.removeAll()
        ACRequest.GET_CAREER_BY_ACADEMY(academicID: index, successCompletion: { (futurePlanCareerDatas) in
            ACData.FUTUREPLANCAREERDATA = futurePlanCareerDatas
            SVProgressHUD.dismiss()
            self.isCareer = true
            self.collectionView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func fetchCareerByTalent(index: String) {
        ACData.FUTUREPLANCAREERDATA.removeAll()
        ACRequest.GET_CAREER_BY_TALENT(talentID: index, successCompletion: { (futurePlanCareerDatas) in
            ACData.FUTUREPLANCAREERDATA = futurePlanCareerDatas
            SVProgressHUD.dismiss()
            self.isCareer = true
            self.collectionView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func fetchCareerDetail(careerID: String) {
        ACRequest.GET_CAREER_DETAIL(careerID: careerID, successCompletion: { (careerDetailData) in
            ACData.CAREERDETAILDATA = careerDetailData
            SVProgressHUD.dismiss()
            self.delegate?.goToCareerDetail()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isCareer {
            return ACData.FUTUREPLANCAREERDATA.count
        } else {
            if isAcademic {
                return ACData.FUTUREPLANACADEMYDATA.count
            } else {
                return ACData.FUTUREPLANTALENTDATA.count
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "futureCollectionCell", for: indexPath as IndexPath) as! FutureCollectionCell
        cell.isAcademy = self.isAcademic
        cell.isCareer = self.isCareer
        cell.config(index: indexPath.row)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if isCareer {
            fetchCareerDetail(careerID: ACData.FUTUREPLANCAREERDATA[indexPath.row].career_id)
        } else {
            if isAcademic {
                fetchCareerByAcademic(index: ACData.FUTUREPLANACADEMYDATA[indexPath.row].academic_id)
            } else {
                fetchCareerByTalent(index: ACData.FUTUREPLANTALENTDATA[indexPath.row].talent_id)
            }
        }
    }
}
