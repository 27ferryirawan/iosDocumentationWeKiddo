//
//  SubjectTeacherChapterListModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 18/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class SubjectTeacherChapterListModel: NSObject {
    var topic_list = [SubjectTeacherChapterTopicListModel]()
    var school_major_id = ""
    var school_level_id = ""
    var subject_id = ""
    var school_grade_id = ""
    
    func objectMapping(json: JSON) {
        school_major_id = json["data"]["chapter"]["extra"]["school_major_id"].stringValue
        school_level_id = json["data"]["chapter"]["extra"]["school_level_id"].stringValue
        subject_id = json["data"]["chapter"]["extra"]["subject_id"].stringValue
        school_grade_id = json["data"]["chapter"]["extra"]["school_grade_id"].stringValue
        for data in json["data"]["chapter"]["topic_list"].arrayValue {
            let d = SubjectTeacherChapterTopicListModel()
            d.objectMapping(json: data)
            topic_list.append(d)
        }
    }
}

class SubjectTeacherChapterTopicListModel: NSObject {
    var chapter_id = ""
    var chapter_desc = ""
    var chapter_name = ""
    
    func objectMapping(json: JSON) {
        chapter_id = json["chapter_id"].stringValue
        chapter_desc = json["chapter_desc"].stringValue
        chapter_name = json["chapter_name"].stringValue
    }
}
