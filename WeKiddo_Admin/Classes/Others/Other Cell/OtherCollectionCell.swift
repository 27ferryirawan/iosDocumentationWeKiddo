//
//  OtherCollectionCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 13/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class OtherCollectionCell: UICollectionViewCell {

    @IBOutlet weak var featuredLabel: UILabel!
    @IBOutlet weak var featuredImage: UIImageView!
    var imageIconOthers = [
                        //                "26": schoolProfile,
                        //                "27": user,
                        //                "28": subject,
                        //                "29": classRoom,
                        //                "31": classSchedule,
                        //                "33": joinClass,
                        "34": "ic_announcment",
                        "35": "eventApproval",
                        "36": "ic_attendance",
                        "37": "ic_permission",
                        "38": "ic_detention",
                        //                "39": notification,
                        //                "40": news,
                        "41": "ic_detention", // -> DEVELOPMEMNT PHASE 1
                        "42": "ic_detention",
                        "43": "ic_ass",
                        //                "44": food,
                        //                "45": fosterParent,
                        //                "46": teacherAttendance,
                        "47": "ic_subjectTop", //subjectTopic
                        //                "48": assignmentChat,
                        //                "49": calendar,
                        "50": "ic_teacher_on_duty", // -> DEVELOPMEMNT PHASE 1
                        "51": "adminDashboard",
                        "52": "dashboardHomeRoom",
                        "53": "dashboardTeacher",
                    ]
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configCell(index: Int) {
        let menu = ACData.LOGINDATA.dashboardCategoryFeature[index].menu_id
        guard let imageName = imageIconOthers["\(menu)"] else {
            return
        }
        featuredImage.image = UIImage(named: imageName)
        featuredLabel.text = ACData.LOGINDATA.dashboardCategoryFeature[index].menu_name
    }
}
