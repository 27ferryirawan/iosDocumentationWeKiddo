//
//  EditProfileFooterCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 16/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol EditProfileFooterCellDelegate: class {
    func editProfileFinish(withMessage: String)
}

class EditProfileFooterCell: UITableViewCell {

    @IBOutlet weak var saveButton: UIButton!
    weak var delegate: EditProfileFooterCellDelegate?
    var address = ""
    var telphone = ""
    var email = ""
    var position = ""
    var teacherImage = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        saveButton.addTarget(self, action: #selector(saveProfile), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func saveProfile() {
        print("Address: \(address), Telephone: \(telphone), Email: \(email), Position: \(position)")
        if address == "" {
            address = ACData.PARENTPROFILEDATA.teacher_address
        }
        if telphone == "" {
            telphone = ACData.PARENTPROFILEDATA.teacher_phone
        }
        if email == "" {
            email = ACData.PARENTPROFILEDATA.teacher_email
        }
        if position == "" {
            position = ACData.PARENTPROFILEDATA.teacher_position
        }
        if let selectedImage = UserDefaults.standard.string(forKey: "SelectedImageFile") {
            if selectedImage != "" {
                teacherImage = selectedImage
            }
        }

        ACRequest.POST_SAVE_NEW_PROFILE(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, teacherAddress: address, teacherPhone: telphone, teacherEmail: email, position: position, teacherImage: teacherImage, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            self.delegate?.editProfileFinish(withMessage: "Success")
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}
