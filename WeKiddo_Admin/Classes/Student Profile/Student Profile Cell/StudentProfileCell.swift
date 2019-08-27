//
//  StudentProfileCell.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 09/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class StudentProfileCell: UITableViewCell {

    @IBOutlet weak var studentImage: UIImageView!
    @IBOutlet weak var nameLbl: UITextField!
    @IBOutlet weak var nisLbl: UITextField!
    @IBOutlet weak var emailLbl: UITextField!
    @IBOutlet weak var birthDateLbl: UITextField!
    @IBOutlet weak var gradeClassLbl: UITextField!
    @IBOutlet weak var schoolLbl: UITextField!
    @IBOutlet weak var comingYearLbl: UITextField!
    @IBOutlet weak var phoneLbl: UITextField!
    @IBOutlet weak var addressLbl: UITextField!
    @IBOutlet weak var changeProfileBtn: UIButton!{
        didSet{
            changeProfileBtn.layer.cornerRadius = 5
            changeProfileBtn.clipsToBounds = true
        }
    }
    @IBOutlet weak var changePasswordBtn: UIButton!{
        didSet{
            changePasswordBtn.layer.cornerRadius = 5
            changePasswordBtn.clipsToBounds = true
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    var detailObj: StudentProfileModel? {
        didSet {
            cellDataSet()
        }
    }
    func cellDataSet() {
        guard let obj = detailObj else {
            return
        }
        //        self.titleLabel.text = title
        self.nameLbl.text = obj.child_name
        self.emailLbl.text = obj.child_email
        self.addressLbl.text = obj.child_address
        self.nisLbl.text = obj.child_nis
        self.phoneLbl.text = obj.child_phone
        self.birthDateLbl.text = obj.child_bod
        self.comingYearLbl.text = obj.coming_year
        self.schoolLbl.text = obj.school_name
        self.gradeClassLbl.text = obj.school_class
        self.studentImage.sd_setImage(
            with: URL(string: (obj.child_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
}
