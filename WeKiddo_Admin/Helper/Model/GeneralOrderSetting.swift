//
//  GeneralOrderSetting.swift
//  AYO CLEAN
//
//  Created by ABDUL AZIS H on 14/09/18.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import EasyMapping

class GeneralOrderSettingModel: NSObject, EKMappingProtocol {
    @objc dynamic var setting_price_per_hour = [SettingPricePerHour]()
    @objc dynamic var setting_promo_code = [SettinPromoCode]()
    @objc dynamic var setting_additional_service = [SettingAdditionalService]()
    
    static func objectMapping() -> EKObjectMapping {
        return EKObjectMapping(
            for: self,
            with: {(mapping) in
                mapping.hasMany(SettingPricePerHour.self, forKeyPath: "setting_price_per_hour", forProperty: "setting_price_per_hour")
                mapping.hasMany(SettinPromoCode.self, forKeyPath: "setting_promo_code", forProperty: "setting_promo_code")
                mapping.hasMany(SettingAdditionalService.self, forKeyPath: "setting_additional_service", forProperty: "setting_additional_service")
        })
    }
}

class SettingPricePerHour: NSObject, EKMappingProtocol {
    @objc dynamic var scph_id = ""
    @objc dynamic var hour_unit = ""
    @objc dynamic var price = ""
    
    static func objectMapping() -> EKObjectMapping {
        return EKObjectMapping(
            for: self,
            with: {(mapping) in
                mapping.mapKeyPath("scph_id", toProperty: "scph_id")
                mapping.mapKeyPath("hour_unit", toProperty: "hour_unit")
                mapping.mapKeyPath("price", toProperty: "price")
        })
    }
    
}

class SettinPromoCode: NSObject, EKMappingProtocol {
    @objc dynamic var spc_id = ""
    @objc dynamic var nominal = ""
    @objc dynamic var nominal_short = ""
    
    static func objectMapping() -> EKObjectMapping {
        return EKObjectMapping(
            for: self,
            with: {(mapping) in
                mapping.mapKeyPath("spc_id", toProperty: "spc_id")
                mapping.mapKeyPath("nominal", toProperty: "nominal")
                mapping.mapKeyPath("nominal_short", toProperty: "nominal_short")
        })
    }
    
}

class SettingAdditionalService: NSObject, EKMappingProtocol {
    
    @objc dynamic var addonId = ""
    @objc dynamic var addonName = ""
    @objc dynamic var addonDuration = ""
    @objc dynamic var addonPrice = ""
    
    static func objectMapping() -> EKObjectMapping {
        return EKObjectMapping(
            for: self,
            with: {(mapping) in
                mapping.mapKeyPath("addon_id", toProperty: "addonId")
                mapping.mapKeyPath("addon_name", toProperty: "addonName")
                mapping.mapKeyPath("addon_duration", toProperty: "addonDuration")
                mapping.mapKeyPath("addon_price", toProperty: "addonPrice")
        })
    }
    
}
