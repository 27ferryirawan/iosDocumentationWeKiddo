//
//  ScoreListModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 06/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class ScoreListModel: NSObject {
    var subject_id = ""
    var assignment_id = ""
    var school_class_id = ""
    var subject_name = ""
    var chapter_name = ""
    var student_list = [ScoreStudentModel]()
    
    func objectMapping(json: JSON) {
        subject_id = json["data"]["score_list"]["subject_id"].stringValue
        assignment_id = json["data"]["score_list"]["assignment_id"].stringValue
        school_class_id = json["data"]["score_list"]["school_class_id"].stringValue
        subject_name = json["data"]["score_list"]["subject_name"].stringValue
        chapter_name = json["data"]["score_list"]["chapter_name"].stringValue
        for data in json["data"]["score_list"]["student_list"].arrayValue {
            let d = ScoreStudentModel()
            d.objectMapping(json: data)
            student_list.append(d)
        }
    }
}

class ScoreStudentModel: NSObject {
    var child_id = ""
    var child_name = ""
    var child_image = ""
    var score = 0
    
    func objectMapping(json: JSON) {
        child_id = json["child_id"].stringValue
        child_name = json["child_name"].stringValue
        child_image = json["child_image"].stringValue
        score = json["score"].intValue
    }
}

class ScoreStudent: NSObject {
    var childID = ""
    var childImage = ""
    var childName = ""
    var score = 0
    var examScore = 0
    
    init(child_id: String, score: Int, child_image: String, child_name: String, exam_score: Int) {
        self.childID = child_id
        self.score = score
        self.childImage = child_image
        self.childName = child_name
        self.examScore = exam_score
    }
}
