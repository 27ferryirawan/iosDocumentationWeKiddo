//
//  NearbyCourseContentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 25/10/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD

protocol NearbyCourseContentCellDelegate: class {
    func goToCourseDetail()
    func goToMore()
}

class NearbyCourseContentCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var detailObj: [NearbyCourseListDataModel]! {
        didSet {
            self.collectionView.reloadData()
        }
    }
    var indexCurrent = 0
    weak var delegate: NearbyCourseContentCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        print("1")
        collectionView.register(UINib(nibName: "NearbyCourseContentCollectionCell", bundle: nil), forCellWithReuseIdentifier: "nearbyCourseContentCollectionCellID")
        moreButton.addTarget(self, action: #selector(getMoreCourses), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func fetchCourseDetail(courseID: String) {
        ACRequest.GET_COURSE_DETAIL(courseID: courseID, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
            ACData.COURSEDETAILDATA = results
            SVProgressHUD.dismiss()
            self.delegate?.goToCourseDetail()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    @objc func getMoreCourses() {
        let courseCatID = ACData.NEARBYDATA.course_list[indexCurrent-1].course_category_id
        ACData.NEARBYCOURSEMOREDATA.removeAll()
        ACRequest.GET_NEARBY_MORE(courseCategoryId: courseCatID, schoolID: ACData.NEARBYDATA.school_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
            ACData.NEARBYCOURSEMOREDATA = results
            SVProgressHUD.dismiss()
            self.delegate?.goToMore()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func config(index: Int){
        indexCurrent = index
        sectionLabel.text = ACData.NEARBYDATA.course_list[index-1].course_category
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailObj.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nearbyCourseContentCollectionCellID", for: indexPath as IndexPath) as! NearbyCourseContentCollectionCell
        cell.contentTitleLabel.text = detailObj[indexPath.row].course_name
        cell.contentImage.sd_setImage(
            with: URL(string: detailObj[indexPath.row].course_image),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(detailObj[indexPath.row].course_id)
        fetchCourseDetail(courseID: detailObj[indexPath.row].course_id)
    }
}
