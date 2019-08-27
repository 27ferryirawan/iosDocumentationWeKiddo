//
//  NearbyCourseMoreViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 29/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class NearbyCourseMoreViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var categoryID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Nearby list", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        collectionView.register(UINib(nibName: "NearbyCourseMoreCell", bundle: nil), forCellWithReuseIdentifier: "nearbyCourseMoreCell")
    }
    func fetchData() {
    }
}

extension NearbyCourseMoreViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5 /*ACData.NEARBYCOURSEMOREDATA.count*/
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nearbyCourseMoreCell", for: indexPath as IndexPath) as! NearbyCourseMoreCell
        cell.config(index: indexPath.row)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(ACData.NEARBYCOURSEMOREDATA[0].course_id)
    }
}
