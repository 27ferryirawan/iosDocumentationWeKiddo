//
//  TotalSchoolContentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 21/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol TotalSchoolContentCellDelegate: class {
    func toSchoolDashboard()
}

class TotalSchoolContentCell: UITableViewCell {
    
    @IBOutlet weak var schoolCollection: UICollectionView!
    
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
        self.delegate?.toSchoolDashboard()
    }
}

extension TotalSchoolContentCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "schoolContentCellID", for: indexPath) as? SchoolContentCell)!
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        fetchDetailSchoolDashbaord()
    }
}
