//
//  AddressModel.swift
//  AYO CLEAN
//
//  Created by ABDUL AZIS H on 12/07/18.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import EasyMapping

class AddressList: NSObject, EKMappingProtocol{
    @objc dynamic var address = [AddressModel]()
    
    static func objectMapping() -> EKObjectMapping {
        return EKObjectMapping(
            for: self,
            with: {(mapping) in
                mapping.hasMany(AddressModel.self, forKeyPath: "message", forProperty: "address")
        })
    }
}

class AddressModel: NSObject, EKMappingProtocol {
    @objc dynamic var address_id = ""
    @objc dynamic var user_id = ""
    @objc dynamic var label = ""
    @objc dynamic var lon = 0.0
    @objc dynamic var lat = 0.0
    @objc dynamic var detail = ""
    @objc dynamic var updated_at = ""
    @objc dynamic var created_at = ""
    
    static func objectMapping() -> EKObjectMapping {
        return EKObjectMapping(
            for: self,
            with: {(mapping) in
                mapping.mapProperties(from:
                    [
                        "address_id",
                        "user_id",
                        "label",
                        "lon",
                        "lat",
                        "detail",
                        "updated_at",
                        "created_at"
                    ])
        })
    }
}
