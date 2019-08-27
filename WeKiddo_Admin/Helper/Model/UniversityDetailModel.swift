//
//  UniversityDetailModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 24/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class UniversityDetailModel: NSObject {
    var university_id = ""
    var university_name = ""
    var university_image = ""
    var university_registration_date = ""
    var university_exam_date = ""
    var university_registration_fee = ""
    var university_phone = ""
    var university_email = ""
    var university_fax = ""
    var university_facebook = ""
    var university_youtube = ""
    var university_instagram = ""
    var university_living_cost = ""
    var university_favourite_major = ""
    var university_address = ""
    var university_latlong = ""
    var university_avg_tution_fee = ""
    var university_terms_payment = ""
    var university_start_date = ""
    var university_details = [UniversityDetailsContentModel]()
    var university_agencies = [UniversityAgenciesContentModel]()
    var university_scholarships = [UniversityScholarshipsContentModel]()
    
    func objectMapping(json: JSON) {
        university_id = json["university_id"].stringValue
        university_name = json["university_name"].stringValue
        university_image = json["university_image"].stringValue
        university_registration_date = json["university_registration_date"].stringValue
        university_exam_date = json["university_exam_date"].stringValue
        university_registration_fee = json["university_registration_fee"].stringValue
        university_phone = json["university_phone"].stringValue
        university_email = json["university_email"].stringValue
        university_fax = json["university_fax"].stringValue
        university_facebook = json["university_facebook"].stringValue
        university_youtube = json["university_youtube"].stringValue
        university_instagram = json["university_instagram"].stringValue
        university_living_cost = json["university_living_cost"].stringValue
        university_favourite_major = json["university_favourite_major"].stringValue
        university_address = json["university_address"].stringValue
        university_latlong = json["university_latlong"].stringValue
        university_avg_tution_fee = json["university_avg_tution_fee"].stringValue
        university_terms_payment = json["university_terms_payment"].stringValue
        university_start_date = json["university_start_date"].stringValue
        for data in json["university_detail"]["details"].arrayValue {
            let d = UniversityDetailsContentModel()
            d.objectMapping(json: data)
            university_details.append(d)
        }
        for data in json["university_detail"]["agencies"].arrayValue {
            let d = UniversityAgenciesContentModel()
            d.objectMapping(json: data)
            university_agencies.append(d)
        }
        for data in json["university_detail"]["scholarships"].arrayValue {
            let d = UniversityScholarshipsContentModel()
            d.objectMapping(json: data)
            university_scholarships.append(d)
        }
    }
}

class UniversityDetailsContentModel: NSObject {
    var university_detail_id = ""
    var university_id = ""
    var university_master_detail_title = ""
    var university_master_detail_description = ""
    
    func objectMapping(json: JSON) {
        university_detail_id = json["university_detail_id"].stringValue
        university_id = json["university_id"].stringValue
        university_master_detail_title = json["university_master_detail_title"].stringValue
        university_master_detail_description = json["university_master_detail_description"].stringValue
    }
}

class UniversityAgenciesContentModel: NSObject {
    var agency_id = ""
    var agency_name = ""
    var agency_address = ""
    var agency_phone_number = ""
    var agency_email = ""
    var agency_image = ""
    var university_id = ""

    func objectMapping(json: JSON) {
        agency_id = json["agency_id"].stringValue
        agency_name = json["agency_name"].stringValue
        agency_address = json["agency_address"].stringValue
        agency_phone_number = json["agency_phone_number"].stringValue
        agency_email = json["agency_email"].stringValue
        agency_image = json["agency_image"].stringValue
        university_id = json["university_id"].stringValue
    }
}

class UniversityScholarshipsContentModel: NSObject {
    var scholarship_id = ""
    var scholarship_name = ""
    var scholarship_media = ""
    var scholarship_description = ""
    var scholarship_term = ""
    var scholarship_facility = ""
    var scholarship_status = ""
    var scholarship_type = ""
    var scholarship_sponsor = ""
    var scholarship_category = ""
    var university_id = ""
    var sponsorship_id = ""
    var scholarship_requirement = ""
    var scholarship_participant_limit = ""
    var scholarship_end_date = ""
    var scholarship_registration_link = ""

    func objectMapping(json: JSON) {
        scholarship_id = json["scholarship_id"].stringValue
        scholarship_name = json["scholarship_name"].stringValue
        scholarship_media = json["scholarship_media"].stringValue
        scholarship_description = json["scholarship_description"].stringValue
        scholarship_term = json["scholarship_term"].stringValue
        scholarship_facility = json["scholarship_facility"].stringValue
        scholarship_status = json["scholarship_status"].stringValue
        scholarship_type = json["scholarship_type"].stringValue
        scholarship_sponsor = json["scholarship_sponsor"].stringValue
        scholarship_category = json["scholarship_category"].stringValue
        university_id = json["university_id"].stringValue
        sponsorship_id = json["sponsorship_id"].stringValue
        scholarship_requirement = json["scholarship_requirement"].stringValue
        scholarship_participant_limit = json["scholarship_participant_limit"].stringValue
        scholarship_end_date = json["scholarship_end_date"].stringValue
        scholarship_registration_link = json["scholarship_registration_link"].stringValue
    }
}
