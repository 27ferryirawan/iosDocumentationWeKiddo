//
//  MoreCoursesViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 26/10/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class MoreCoursesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Course Detail", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        collectionView.register(UINib(nibName: "MoreCoursesCollectionCell", bundle: nil), forCellWithReuseIdentifier: "moreCoursesContentCollectionCellID")
    }
}

extension MoreCoursesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ACData.NEARBYCOURSEMOREDATA.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "moreCoursesContentCollectionCellID", for: indexPath) as? MoreCoursesCollectionCell)!
        cell.detailObj = ACData.NEARBYCOURSEMOREDATA[indexPath.row]
        return cell
    }
}
