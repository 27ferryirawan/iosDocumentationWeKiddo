//
//  DetailTaskAdminGroupCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 02/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class DetailTaskAdminGroupCell: UITableViewCell {

    @IBOutlet weak var adminCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        adminCollection.register(UINib(nibName: "DetailTaskAdminGroupCollectionCell", bundle: nil), forCellWithReuseIdentifier: "detailTaskAdminGroupCollectionCellID")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension DetailTaskAdminGroupCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "detailTaskAdminGroupCollectionCellID", for: indexPath) as? DetailTaskAdminGroupCollectionCell)!
        
        return cell
    }
}
