//
//  ClassroomContentCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 26/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class ClassroomContentCell: UITableViewCell {

    @IBOutlet weak var studentLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var classObjc : ClassroomClassesModel?{
        didSet{
            cellDataSet()
        }
    }
    
    func cellDataSet(){
        guard let obj = classObjc else { return }
        studentLabel.text = "\(obj.countStudent)"
        teacherLabel.text = obj.teacher_name
        classLabel.text = obj.school_class
    }
}
