//
//  ProfileModel.swift
//  AYO CLEAN
//
//  Created by zein rezky chandra on 14/07/18.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import EasyMapping

class ProfileModelObject: NSObject, EKMappingProtocol {
    @objc dynamic var userProfile: ProfileModel?
    @objc dynamic var address = [AddressModel]()
    
    static func objectMapping() -> EKObjectMapping {
        return EKObjectMapping(
            for: self,
            with: {(mapping) in
                mapping.hasOne(ProfileModel.self, forKeyPath: "user", forProperty: "userProfile")
                mapping.hasMany(AddressModel.self, forKeyPath: "address", forProperty: "address")
        })
    }
}

class ProfileModel: NSObject, EKMappingProtocol {
    @objc dynamic var full_name = ""
    @objc dynamic var email = ""
    @objc dynamic var phone = ""
    @objc dynamic var id = ""
    @objc dynamic var address = ""
    @objc dynamic var wa_no = ""
    @objc dynamic var dob = ""
    @objc dynamic var gender = ""
    @objc dynamic var avatar = ""
    @objc dynamic var last_login = Date()
    @objc dynamic var date_created = Date()
    @objc dynamic var address_id = ""
    @objc dynamic var user_id = ""
    @objc dynamic var label = ""
    @objc dynamic var lon = ""
    @objc dynamic var lat = ""
    @objc dynamic var detail = ""
    @objc dynamic var updated_at = Date()
    @objc dynamic var created_at = Date()

    /*
    convenience init(full_name:String, email:String, phone:String, id:String, wa_no:String, dob:Date, gender:String, avatar:String, last_login:Date, date_created:Date) {
        self.init()
        self.full_name = full_name
        self.email = email
        self.phone = phone
        self.id = id
        self.wa_no = wa_no
        self.dob = dob
        self.gender = gender
        self.avatar = avatar
        self.last_login = last_login
        self.date_created = date_created
    }
    */
    
    static func objectMapping() -> EKObjectMapping {
        return EKObjectMapping(
            for: self,
            with: {(mapping) in
                mapping.mapProperties(from:
                    [
                        "address",
                        "id",
                        "full_name",
                        "email",
                        "phone",
                        "id",
                        "wa_no",
                        "gender",
                        "dob",
                        "avatar",
                    ])
                
                let dateFormatter = DateFormatter()
                let dateFormatter2 = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                dateFormatter2.dateFormat = "yyyy-MM-dd"
                mapping.mapKeyPath("last_login", toProperty: "last_login", with: dateFormatter)
                mapping.mapKeyPath("date_created", toProperty: "date_created", with: dateFormatter)
        })
    }
    
}
