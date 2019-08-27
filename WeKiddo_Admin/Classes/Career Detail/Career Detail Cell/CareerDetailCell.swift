//
//  CareerDetailCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 23/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD

protocol CareerDetailDelegate: class {
    func goToUniversityList()
}

class CareerDetailCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var contentTalent: UILabel!
    @IBOutlet weak var contentAcademic: UILabel!
    @IBOutlet weak var contentUniversityMajor: UICollectionView!
    @IBOutlet weak var contentDuties: UILabel!
    @IBOutlet weak var contentWorkingHours: UILabel!
    @IBOutlet weak var contentRangeSalary: UILabel!
    @IBOutlet weak var contentDesc: UILabel!
    @IBOutlet weak var contentTitle: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    var academicArray: [String] = []
    var talentArray: [String] = []
    
    weak var delegate: CareerDetailDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentUniversityMajor.dataSource = self
        contentUniversityMajor.delegate = self
        contentUniversityMajor.register(UINib(nibName: "CareerUniversityMajorCell", bundle: nil
        ), forCellWithReuseIdentifier: "careerUniversityMajorCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func fetchUniversityByMajor(majorID: String) {
        ACData.UNIVERSITYDATA.removeAll()
        ACRequest.GET_UNIVERSITY_BY_MAJOR(majorID: majorID, successCompletion: { (universityDatas) in
            ACData.UNIVERSITYDATA = universityDatas
            SVProgressHUD.dismiss()
            self.delegate?.goToUniversityList()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func config() {
        guard let object = ACData.CAREERDETAILDATA else {
            return
        }
        contentImage.sd_setImage(
            with: URL(string: object.career_image),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        contentTitle.text = object.career_name
        contentDesc.text = object.career_description
        contentRangeSalary.text = object.range_salary
        contentDuties.text = object.career_duties
        for objects in object.academic {
            academicArray.append(objects.academic_name)
        }
        for objects in object.talent {
            talentArray.append(objects.talent_name)
        }
        contentAcademic.text = "\(academicArray.joined(separator:","))"
        contentTalent.text = "\(talentArray.joined(separator: ","))"
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ACData.CAREERDETAILDATA.universityMajor.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "careerUniversityMajorCell", for: indexPath as IndexPath) as! CareerUniversityMajorCell
        cell.config(index: indexPath.row)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        fetchUniversityByMajor(majorID: ACData.CAREERDETAILDATA.universityMajor[indexPath.row].major_id)
    }
}
