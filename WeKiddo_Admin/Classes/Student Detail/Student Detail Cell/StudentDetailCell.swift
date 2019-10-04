//
//  StudentDetailCell.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 04/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol StudentDetailCellDelegate:class{
    func toAddParentPopUp()
}

class StudentDetailCell: UITableViewCell {

    weak var delegate:StudentDetailCellDelegate?
    @IBOutlet weak var studentImage: UIImageView!{
        didSet{
            studentImage.layer.cornerRadius = studentImage.frame.size.width/2
        }
    }
    @IBOutlet weak var studentNameLbl: UILabel!
    @IBOutlet weak var studentNISLbl: UILabel!
    @IBOutlet weak var studentAddressLbl: UILabel!
    @IBOutlet weak var studentEmailLbl: UILabel!
    @IBOutlet weak var studentPhoneLbl: UILabel!
    @IBOutlet weak var studentJoinLbl: UILabel!
    @IBOutlet weak var studentBdateLbl: UILabel!
    @IBOutlet weak var studentGenderLbl: UILabel!
    @IBOutlet weak var studentCrossMajorLbl: UILabel!
    @IBOutlet weak var addParentBtn: UIButton!
    var yearId = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        addParentBtn.addTarget(self, action: #selector(addParent), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @objc func addParent(){
        self.delegate?.toAddParentPopUp()
    }
    var studentObjc : StudentDetailModel?{
        didSet{
            cellDataSet()
        }
    }
    func cellDataSet(){
        guard let obj = studentObjc else { return }
        self.studentImage.sd_setImage(
            with: URL(string: (obj.child_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        studentNameLbl.text = ": \(obj.child_name)"
        studentNISLbl.text = ": \(obj.nisn)"
        studentAddressLbl.text = ": \(obj.child_address)"
        studentEmailLbl.text = ": \(obj.child_email)"
        studentPhoneLbl.text = ": \(obj.child_phone)"
        studentJoinLbl.text = ":"
        studentBdateLbl.text = ": \(getDMMMY(time: obj.child_bod))"
        studentGenderLbl.text = ": \(obj.child_gender)"
        studentCrossMajorLbl.text = ":"
    }
}
extension StudentDetailCell {
    func getDMMMY(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        // then convert date to string again
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "dd MMM yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
