//
//  HomeGeneralDataModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 19/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeGeneralDataModel: NSObject {
     var homeProfile_child_name = ""
     var homeProfile_child_image = ""
     var homeProfile_class = ""
     var homeProfile_school_name = ""
     var homeProfile_school_image = ""
     var homeProfile_teacher_name = ""
     var homeProfile_teacher_phone = ""
     var session_subjetName = ""
     var session_start = ""
     var session_end = ""
     var session_id = ""
     var session_late = ""
     var session_detention = ""
     var permission_count = ""
     var approval_count = ""
     var information_permissionCount = ""
     var information_approvalCount = ""
     var childID = ""

    func objectMapping(json: JSON) {
        homeProfile_child_name = json["information"]["homeprofile"]["child"]["name"].stringValue
        homeProfile_child_image = json["information"]["homeprofile"]["child"]["image"].stringValue
        homeProfile_class = json["information"]["homeprofile"]["class"].stringValue
        homeProfile_school_name = json["information"]["homeprofile"]["school"]["name"].stringValue
        homeProfile_school_image = json["information"]["homeprofile"]["school"]["image"].stringValue
        homeProfile_teacher_name = json["information"]["homeprofile"]["teacher"]["name"].stringValue
        homeProfile_teacher_phone = json["information"]["homeprofile"]["teacher"]["phone"].stringValue
        session_subjetName = json["information"]["session"]["subjectName"].stringValue
        session_start = json["information"]["session"]["start"].stringValue
        session_end = json["information"]["session"]["end"].stringValue
        session_id = json["information"]["session"]["session_id"].stringValue
        session_late = json["information"]["session"]["late"].stringValue
        session_detention = json["information"]["session"]["detention"].stringValue
        permission_count = json["information"]["Permission Count"]["permissionCount"].stringValue
        approval_count = json["information"]["Approval"]["approvalCount"].stringValue
        information_permissionCount = json["information"]["information"]["permissionCount"].stringValue
        information_approvalCount = json["information"]["information"]["approvalCount"].stringValue
        childID = json["information"]["child"]["child_id"].stringValue
    }
}

