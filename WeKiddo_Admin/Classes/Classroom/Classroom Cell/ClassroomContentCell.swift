//
//  ClassroomContentCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 26/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol ClassroomContentDelegate : class{
    func toDetail(schoolClassId:String)
}

class ClassroomContentCell: UITableViewCell {

    @IBOutlet weak var toDetailBtn: UIButton!
    @IBOutlet weak var studentLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    weak var delegate : ClassroomContentDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        toDetailBtn.addTarget(self, action: #selector(toDetail), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    var classObjc : ClassroomClassesModel?{
        didSet{
            cellDataSet()
        }
    }
     @objc func toDetail(){
        guard let obj = classObjc else { return }
        guard let yearId = ACData.LOGINDATA.dashboardSchoolMenu[0].year_id else {
            return
        }
        print(ACData.LOGINDATA.userID)
        print(obj.school_class_id)
        print(yearId)
        ACRequest.POST_CLASSROOM_DETAIL(userId: ACData.LOGINDATA.userID, school_class_id: obj.school_class_id, yearId: yearId, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (classDetailData) in
            ACData.CLASSROOMDETAILDATA = classDetailData
            print(ACData.CLASSROOMDETAILDATA.list_student.count)
            SVProgressHUD.dismiss()
            self.delegate?.toDetail(schoolClassId: obj.school_class_id)
        }, failCompletion: { (message) in
             SVProgressHUD.dismiss()
        })
    }
    func cellDataSet(){
        guard let obj = classObjc else { return }
        if obj.countStudent > 1 {
            studentLabel.text = "\(obj.countStudent) Students"
        } else {
            studentLabel.text = "\(obj.countStudent) Student"
        }
        teacherLabel.text = obj.teacher_name
        classLabel.text = obj.school_class
    }
}
