//
//  AddClassroomTeacherListCell.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 07/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol AddClassroomTeacherListCellDelegate : class {
    func backToAdd(teacherId:String, teacherName:String, teacherImage:String, teacherNUPTK:String)
}

class AddClassroomTeacherListCell: UITableViewCell {

    weak var delegate : AddClassroomTeacherListCellDelegate?
    @IBOutlet weak var teacherName: UILabel!
    @IBOutlet weak var teacherProfileImage: UIImageView!
    @IBOutlet weak var selectTeacherBtn: UIButton!
    @IBOutlet weak var teacherNUPTK: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectTeacherBtn.addTarget(self, action: #selector(selectTeacherDone), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    var teacherObj : AddClassroomTeacherListModel?{
        didSet{
            cellDataSet()
        }
    }
    func cellDataSet(){
        guard let obj = teacherObj else { return }
        teacherName.text = obj.teacher_name
        teacherNUPTK.text = obj.nuptk
        self.teacherProfileImage.sd_setImage(
            with: URL(string: (obj.teacher_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
    @objc func selectTeacherDone(){
        guard let obj = teacherObj else { return }
        self.delegate?.backToAdd(teacherId: obj.teacher_id!, teacherName: obj.teacher_name, teacherImage: obj.teacher_image, teacherNUPTK: obj.nuptk)
    }
}
