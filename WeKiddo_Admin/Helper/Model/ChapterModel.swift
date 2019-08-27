//
//  ChapterModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 06/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class ChapterModel: NSObject {
    var chapter_list = [ChapterListModel]()
    var class_list = [ChapterClassModel]()
    
    func objectMapping(json: JSON) {
        for data in json["data"]["subject_data"]["chapter_list"].arrayValue {
            let d = ChapterListModel()
            d.objectMapping(json: data)
            chapter_list.append(d)
        }
        for data in json["data"]["subject_data"]["class_list"].arrayValue {
            let d = ChapterClassModel()
            d.objectMapping(json: data)
            class_list.append(d)
        }
    }
}

class ChapterListModel: NSObject {
    var chapter_id = ""
    var chapter_name = ""
    
    func objectMapping(json: JSON) {
        chapter_id = json["chapter_id"].stringValue
        chapter_name = json["chapter_name"].stringValue
    }
}

class ChapterClassModel: NSObject {
    var school_class_id = ""
    var school_class = ""
    
    func objectMapping(json: JSON) {
        school_class_id = json["school_class_id"].stringValue
        school_class = json["school_class"].stringValue
    }
}

class ClassModel: NSObject {
    var school_class_id = ""
    var due_date = ""
    
    init(schoolClass: String, dueDate: String) {
        self.school_class_id = schoolClass
        self.due_date = dueDate
    }
}

