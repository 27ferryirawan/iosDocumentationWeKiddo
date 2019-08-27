//
//  MoreSchoolCell.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 03/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol SchoolMoreDelegate: class {
    func gotoSchoolDetail(schoolId : String)
}

class MoreSchoolCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    
    
    @IBOutlet weak var schoolCollection: UICollectionView!
    weak var delegate : SchoolMoreDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        schoolCollection.delegate = self
        schoolCollection.dataSource = self
        schoolCollection.register(UINib(nibName: "MoreSchoolCollectionCell", bundle: nil), forCellWithReuseIdentifier: "moreSchoolCollectionCell")
        //        self.addConstraint(NSLayoutConstraint(item: schoolCollection, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant:  viewHeight(dataCount: ACData.MENUCATEGORYOTHERSDATA.count)))
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func viewHeight(dataCount: Int)->CGFloat{
        var viewHeight: CGFloat = 0
        if(dataCount%4 != 0){
            viewHeight = CGFloat((dataCount/4*105+105) + (dataCount/4*10+10)) // sisa tinggi + tinggi 1 cell
            return viewHeight
        }else{
            viewHeight = CGFloat((dataCount/4*105) + (dataCount/4*10)) //15 = sisa tinggi
            return viewHeight
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ACData.LOGININFODATA.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "moreSchoolCollectionCell", for: indexPath) as? MoreSchoolCollectionCell)!
        cell.configCell(index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "moreSchoolCollectionCell", for: indexPath) as? MoreSchoolCollectionCell)!
        self.delegate?.gotoSchoolDetail(schoolId: cell.getSchoolId(index: indexPath.row))
    }
    
}
