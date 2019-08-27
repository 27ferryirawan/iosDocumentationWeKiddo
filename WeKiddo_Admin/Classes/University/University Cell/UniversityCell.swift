//
//  UniversityCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 23/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD

protocol UniversityListDelegate: class {
    func goToDetail()
    func openPreview()
}

class UniversityCell: UITableViewCell {

    @IBOutlet weak var contentButton: UIButton!
    @IBOutlet weak var contentViewBg: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var indexLabel: UILabel!
    var universityIndex = 0
    
    weak var delegate: UniversityListDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentButton.addTarget(self, action: #selector(fetchDetail), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellDataSet(index: Int) {
        universityIndex = index
        indexLabel.text = "\(index+1)"
        contentLabel.text = ACData.UNIVERSITYDATA[index].university_name
        contentImage.sd_setImage(
            with: URL(string: "\(ACData.UNIVERSITYDATA[index].university_image)"),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
    @objc func fetchDetail() {
        print(ACData.UNIVERSITYDATA[universityIndex].university_id)
        ACRequest.GET_UNIVERSITY_DETAIL(universityID: "\(ACData.UNIVERSITYDATA[universityIndex].university_id)", successCompletion: { (universityData) in
            func openPreview() {
                // TODO: Parsing data from JSON and map to inner model
            }
            
            ACData.UNIVERSITYDETAILDATA = universityData
            SVProgressHUD.dismiss()
            self.delegate?.goToDetail()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
}
