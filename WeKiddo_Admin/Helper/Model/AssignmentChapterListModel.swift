//
//  AssignmentChapterListModel.swift
//  WeKiddo_Admin
//
//  Created by Yosua Hoo on 28/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AssignmentChapterListModel {
    var chapterList = [AssignmentChapterListContentModel]()
    
    func objectMapping(json: JSON){
        for data in json["data"]["chapter_list"].arrayValue{
            let d = AssignmentChapterListContentModel()
            d.objectMapping(json: data)
            chapterList.append(d)
        }
    }
}

class AssignmentChapterListContentModel {
    var chapter_id = ""
    var chapter_name = ""
    
    func objectMapping(json: JSON){
        chapter_id = json["chapter_id"].stringValue
        chapter_name = json["chapter_name"].stringValue
    }
}
