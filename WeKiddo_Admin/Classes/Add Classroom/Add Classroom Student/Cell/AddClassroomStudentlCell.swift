//
//  AddClassroomStudentlCell.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 07/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
protocol AddClassroomStudentlCellDelegate : class{
    func toAddClassroom(childId:String, childName:String, childImg:String, childNIS:String)
}

class AddClassroomStudentlCell: UITableViewCell {

    weak var delegate:AddClassroomStudentlCellDelegate?
    
    @IBOutlet weak var studentTypeLbl: UILabel!
    @IBOutlet weak var studentImage: UIImageView!{
        didSet{
            studentImage.layer.cornerRadius = studentImage.frame.size.width/2
        }
    }
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentNIS: UILabel!
    @IBOutlet weak var selectStudentBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectStudentBtn.addTarget(self, action: #selector(toAddClassroom), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func toAddClassroom(){
        guard let obj = studentObj else { return }
        self.delegate?.toAddClassroom(childId:obj.child_id!, childName:obj.child_name, childImg:obj.child_image, childNIS:obj.child_nis)
    }
    
    var studentObj : AddClassroomStudentSearchModel?{
        didSet{
            cellDataSet()
        }
    }
    func cellDataSet(){
        guard let obj = studentObj else { return }
        studentName.text = obj.child_name
        studentNIS.text = obj.child_nis
        self.studentImage.sd_setImage(
            with: URL(string: (obj.child_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
}
