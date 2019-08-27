//
//  UserViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 24/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "User", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "User", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        collectionView.register(UINib(nibName: "UserProfileCollectionCell", bundle: nil), forCellWithReuseIdentifier: "userProfileCollectionCellID")
        collectionView.register(UINib(nibName: "CollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "collectionSectionTitleReusableViewCell")
    }
}

extension UserViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func indexTitles(for collectionView: UICollectionView) -> [String]? {
        return ["Administration", "Homeroom Teacher", "Teacher"]
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "collectionSectionTitleReusableViewCell", for: indexPath) as? CollectionReusableView{
            sectionHeader.sectionHeaderLabel.text = "Section \(indexPath.section)"
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        } else if section == 1 {
            return 6
        } else {
            return 2
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "userProfileCollectionCellID", for: indexPath) as? UserProfileCollectionCell)!
            
            return cell
        } else if indexPath.section == 1 {
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "userProfileCollectionCellID", for: indexPath) as? UserProfileCollectionCell)!
            
            return cell
        } else {
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "userProfileCollectionCellID", for: indexPath) as? UserProfileCollectionCell)!
            
            return cell
        }
    }
}

