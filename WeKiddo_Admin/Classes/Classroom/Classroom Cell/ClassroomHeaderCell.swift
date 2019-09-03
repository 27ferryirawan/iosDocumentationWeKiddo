//
//  ClassroomHeaderCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 26/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import SVProgressHUD

protocol ClassroomDelegate : class {
    func refreshData(levelCount : Int, levelName : [String], classLevelCount : [Int])
    func firstPickerClass() -> String
}

class ClassroomHeaderCell: UITableViewCell {
    
    
    @IBOutlet weak var schoolNameLbl: UILabel!
    @IBOutlet weak var schoolGradeLbl: UILabel!
    @IBOutlet weak var schoolLogoImg: UIImageView!
    var selectedSch : String?
    var levelCount = 0
    var levelName = [String]()
    var classLevelCount = [Int]()
    
    weak var delegate : ClassroomDelegate?
    var schools: [String] = []
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var schoolPicker: ButtonLeftSpace!
    var detailObj : ClassroomDashModel?{
        didSet{
            cellConfig()
            schoolPicker.setTitle(self.delegate?.firstPickerClass(), for: .normal)
        }
    }
    
    func cellConfig() {
        guard let obj = detailObj else { return }
        schoolNameLbl.text = obj.school_name
        schoolGradeLbl.text = obj.school_grade
        self.schoolLogoImg.sd_setImage(
            with: URL(string: (obj.school_logo)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        schools.removeAll()
        for value in ACData.LOGINDATA.dashboardSchoolMenu {
            schools.append(value.school_name!)
        }
        self.schoolPicker.addTarget(self, action: #selector(showSchoolPicker), for: .touchUpInside)
    }
    
    @objc func showSchoolPicker() {
        ActionSheetStringPicker.show(
            withTitle: "Select School",
            rows: schools,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let schoolID = ACData.LOGINDATA.dashboardSchoolMenu[indexes].school_id, let yearId = ACData.LOGINDATA.dashboardSchoolMenu[indexes].year_id else {
                    return
                }
                self.getSchoolData(schoolID: schoolID, yearID: yearId)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    func getSchoolData(schoolID: String, yearID: String) {
        ACData.CLASSROOMDASH.classroom_class_list.removeAll()
        ACRequest.POST_CLASSROOM_DASH(userId: ACData.LOGINDATA.userID, schoolId: schoolID, yearId: yearID, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (classList) in
            ACData.CLASSROOMDASH = classList
            SVProgressHUD.dismiss()
            DispatchQueue.main.async {
                self.levelCount = ACData.CLASSROOMDASH.classroom_class_list.count
                for indexes in ACData.CLASSROOMDASH.classroom_class_list {
                    self.levelName.append(indexes.school_level)
                    self.classLevelCount.append(indexes.classroom_classes.count)
                }
                self.delegate?.refreshData(levelCount: self.levelCount, levelName: self.levelName, classLevelCount: self.classLevelCount)
            }
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    
}
