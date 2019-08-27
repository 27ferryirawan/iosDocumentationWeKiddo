//
//  AttachmentBannerModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 10/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AttachmentBannerModel: NSObject {
    var file_id = ""
    var file_url = ""
    var file_type = ""
    
    func objectMapping(json: JSON) {
        file_id = json["data"]["media_file"]["id"].stringValue
        file_url = json["data"]["media_file"]["url"].stringValue
        file_type = json["data"]["media_file"]["media_type_id"].stringValue
    }
}

class DescriptionModel: NSObject {
    var titleText = ""
    var descText = ""
    
    init(title: String, description: String) {
        self.titleText = title
        self.descText = description
    }
}

class AttachmentImageMediaModel: NSObject {
    var media_type_id = ""
    var url = ""
    var media_id = ""
    
    func objectMapping(json: JSON) {
        media_type_id = json["data"]["media_file"]["media_type_id"].stringValue
        url = json["data"]["media_file"]["url"].stringValue
        media_id = json["data"]["media_file"]["id"].stringValue
    }
}

class AttachmentVideoMediaModel: NSObject {
    var file_id = ""
    var file_url = ""
    var file_type_id = ""
    
    func objectMapping(json: JSON) {
        file_id = json["data"]["media_file"]["id"].stringValue
        file_url = json["data"]["media_file"]["url"].stringValue
        file_type_id = json["data"]["media_file"]["media_type_id"].stringValue
    }
}

class BannerMediaModel: Codable {
    var file_id = ""
    var file_url = ""
    var file_type = ""
    
    init(fileID: String, fileURL: String, fileType: String) {
        self.file_id = fileID
        self.file_url = fileURL
        self.file_type = fileType
    }
}

class GalleryMediaModel: Codable {
    var file_id = ""
    var file_url = ""
    var file_type = ""
    
    init(fileID: String, fileURL: String, fileType: String) {
        self.file_id = fileID
        self.file_url = fileURL
        self.file_type = fileType
    }
}

class VideoMediaModel: Codable {
    var file_id = ""
    var file_url = ""
    var file_type = ""
    
    init(fileID: String, fileURL: String, fileType: String) {
        self.file_id = fileID
        self.file_url = fileURL
        self.file_type = fileType
    }
}

