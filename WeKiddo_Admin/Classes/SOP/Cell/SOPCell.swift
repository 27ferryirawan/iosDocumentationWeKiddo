//
//  SOPCell.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 08/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
protocol SOPCellDelegate:class{
    func toDetail()
}
class SOPCell: UITableViewCell {

    weak var delegate:SOPCellDelegate?
    @IBOutlet weak var sopTitle: UILabel!
    @IBOutlet weak var sopImage: UIImageView!
    @IBOutlet weak var toDetailBtn: UIButton!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        toDetailBtn.addTarget(self, action: #selector(toDetail), for: .touchUpInside)
    }
    var sopObjc:SOPListModel?{
        didSet{
            cellDataSet()
        }
    }
    @objc func toDetail(){
        guard let obj = sopObjc else { return }
        ACRequest.POST_GET_SOP_DETAIL(sop_id: obj.sop_id, userId: ACData.LOGINDATA.userID, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (sopDetail) in
            ACData.SOPDETAILDATA = sopDetail
            SVProgressHUD.dismiss()
            self.delegate?.toDetail()
        }) { (status) in
            SVProgressHUD.dismiss()
        }
    }
    func cellDataSet(){
        guard let obj = sopObjc else { return }
        sopTitle.text = obj.sop_title
        self.sopImage.sd_setImage(
            with: URL(string: (obj.sop_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
}
