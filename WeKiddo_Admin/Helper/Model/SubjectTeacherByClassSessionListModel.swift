//
//  SubjectTeacherByClassSessionListModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 19/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class SubjectTeacherByClassSessionListModel: NSObject {
    var detailed = [SubjectTeacherByClassSessionListDetailModel]()
    var chapter_list = [SubjectTeacherByClassSessionListChapterListModel]()
    
    func objectMapping(json: JSON) {
        for data in json["data"]["detail_by_class"]["detailed"]["data"].arrayValue {
            let d = SubjectTeacherByClassSessionListDetailModel()
            d.objectMapping(json: data)
            detailed.append(d)
        }
        for data in json["data"]["detail_by_class"]["chapter_list"].arrayValue {
            let d = SubjectTeacherByClassSessionListChapterListModel()
            d.objectMapping(json: data)
            chapter_list.append(d)
        }
    }
}

class SubjectTeacherByClassSessionListChapterListModel: NSObject {
    var chapter_name = ""
    var chapter_id = ""
    
    func objectMapping(json: JSON) {
        chapter_name = json["chapter_name"].stringValue
        chapter_id = json["chapter_id"].stringValue
    }
}

class SubjectTeacherByClassSessionListDetailModel: NSObject {
    var end_date = ""
    var from_date = ""
    var week_count = 0
    var chapter = [SubjectTeacherByClassSessionListDetailChapterListModel]()
    
    func objectMapping(json: JSON) {
        end_date = json["end_date"].stringValue
        from_date = json["from_date"].stringValue
        week_count = json["week_count"].intValue
        for data in json["chapter"].arrayValue {
            let d = SubjectTeacherByClassSessionListDetailChapterListModel()
            d.objectMapping(json: data)
            chapter.append(d)
        }
    }
}

class SubjectTeacherByClassSessionListDetailChapterListModel: NSObject {
    var school_session_id = ""
    var chapter_name = ""
    var session_count = 0
    var chapter_id = ""
    var session_date = ""
    
    func objectMapping(json: JSON) {
        school_session_id = json["school_session_id"].stringValue
        chapter_name = json["chapter_name"].stringValue
        session_count = json["session_count"].intValue
        chapter_id = json["chapter_id"].stringValue
        session_date = json["session_date"].stringValue
    }
}

class SubjectTeacherByClassSessionSelected: Codable {
    var school_session_id = ""
    var chapter_id = ""
    var chapter_name = ""
    var objectSection = 0
    var objectIndex = 0

    init(schoolSessionID: String, chapterID: String, chapterName: String, objectAtSection: Int, objectAtIndex: Int) {
        self.school_session_id = schoolSessionID
        self.chapter_id = chapterID
        self.chapter_name = chapterName
        self.objectSection = objectAtSection
        self.objectIndex = objectAtIndex
    }
}
