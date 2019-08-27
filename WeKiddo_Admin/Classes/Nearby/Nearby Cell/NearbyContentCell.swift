//
//  NearbyContentCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 13/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD

protocol NearbyDelegate: class {
    func goToCourseDetail()
}

class NearbyContentCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var arrayForCollectionView : [NearbyCourseModel]! {
        didSet {
            self.collectionView.reloadData()
        }
    }
    weak var delegate: NearbyDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        print("1")
        // Initialization code
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "NearbyContentCollectionCell", bundle: nil), forCellWithReuseIdentifier: "nearbyContentCollectionCell")
//        moreButton.addTarget(self, action: #selector(goToMore), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func fetchCourseDetail(courseID: String) {
        ACRequest.GET_COURSE_DETAIL(courseID: courseID, successCompletion: { (courseDetailData) in
            ACData.COURSEDETAILDATA = courseDetailData
            SVProgressHUD.dismiss()
            self.delegate?.goToCourseDetail()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func config(index: Int){
        print("2")
        sectionLabel.text = ACData.NEARBYDATA[index-1].course_category
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayForCollectionView.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nearbyContentCollectionCell", for: indexPath as IndexPath) as! NearbyContentCollectionCell
        cell.contentTitleLabel.text = arrayForCollectionView[indexPath.row].course_name
        cell.contentImage.sd_setImage(
            with: URL(string: arrayForCollectionView[indexPath.row].course_image),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(arrayForCollectionView[indexPath.row].course_id)
        fetchCourseDetail(courseID: arrayForCollectionView[indexPath.row].course_id)
    }
}
