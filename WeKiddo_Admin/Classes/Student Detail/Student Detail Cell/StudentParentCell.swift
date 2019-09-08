//
//  StudentParentCell.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 04/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol StudentParentCellDelegate : class{
    func toPopup(parentName:String, parentImage:String, parentRelation:String, parentPhone:String, parentAddress:String, parentEmail:String, parentGender:String, parentId : String)
}

class StudentParentCell: UITableViewCell {

    weak var delegate : StudentParentCellDelegate?
    @IBOutlet weak var studentParentView: UIView!{
        didSet{
            studentParentView.layer.cornerRadius = 5
            studentParentView.layer.borderWidth = 1
            studentParentView.layer.borderColor = UIColor(hex: "#D3D3D3").cgColor
            studentParentView.clipsToBounds = true
        }
    }
    @IBOutlet weak var parentimage: UIImageView!{
        didSet{
            parentimage.layer.cornerRadius = parentimage.frame.size.width/2
        }
    }
    @IBOutlet weak var parentName: UILabel!
    @IBOutlet weak var parentPhone: UILabel!
    @IBOutlet weak var parentGender: UILabel!
    @IBOutlet weak var toEditPopupBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        toEditPopupBtn.addTarget(self, action: #selector(toPopUp), for: .touchUpInside)
    }

    @objc func toPopUp(){
        guard let obj = parentObjc else { return }
        var parentRelation = ""
        var gender = ""
        if obj.gender == "male" || obj.gender == "Male"{
            parentRelation = "Father"
            gender = "Male"
        } else if obj.gender == "female" || obj.gender == "Female"{
            parentRelation = "Mother"
            gender = "Female"
        } else {
            parentRelation = "Guardian"
            gender = "Gender"
        }
        self.delegate?.toPopup(parentName: obj.parent_name, parentImage: obj.parent_image, parentRelation: parentRelation, parentPhone: obj.parent_phone, parentAddress: obj.parent_address, parentEmail: obj.parent_email, parentGender: gender, parentId : obj.parent_id)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    var parentObjc : ChildParentModel?{
        didSet{
            cellDataSet()
        }
    }
    
    func cellDataSet(){
        guard let obj = parentObjc else { return }
        self.parentimage.sd_setImage(
            with: URL(string: (obj.parent_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        parentName.text = obj.parent_name
        parentPhone.text = obj.parent_phone
        parentGender.text = obj.gender
    }
}
