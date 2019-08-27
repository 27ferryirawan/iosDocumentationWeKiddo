//
//  SchoolCell.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 29/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol SchoolDelegate: class {
    func gotoSchoolDetail(schoolId : String)
    func goToMore()
    
}

class SchoolCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    weak var delegate : SchoolDelegate?
    
    @IBOutlet weak var moreSchoolBtn: UIButton!
    @IBOutlet weak var schoolCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        schoolCollection.delegate = self
        schoolCollection.dataSource = self
        schoolCollection.register(UINib(nibName: "LoginInfoCollectionCell", bundle: nil), forCellWithReuseIdentifier: "loginInfoCollectionCell")
        moreSchoolBtn.addTarget(self, action: #selector(goToMorePage), for: .touchUpInside)
        
    }
    
    @objc func goToMorePage() {
        self.delegate?.goToMore()
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
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "loginInfoCollectionCell", for: indexPath) as? LoginInfoCollectionCell)!
        cell.configCell(index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "loginInfoCollectionCell", for: indexPath) as? LoginInfoCollectionCell)!
        self.delegate?.gotoSchoolDetail(schoolId: cell.getSchoolId(index: indexPath.row))
    }
}
