//
//  HydroCategoryModel.swift
//  AYO CLEAN
//
//  Created by ABDUL AZIS H on 22/07/18.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import EasyMapping

enum HydroCategoryModelType: String {
    case category = "Perkategori"
    case meter = "Permeter"
}

class HydroDataModel: NSObject, EKMappingProtocol {
    @objc dynamic var category = [HydroCategoryModel]()
    @objc dynamic var promo = [String]()
    
    static func objectMapping() -> EKObjectMapping {
        return EKObjectMapping(
            for: self,
            with: {(mapping) in
                mapping.hasMany(HydroCategoryModel.self, forKeyPath: "hydro_cat", forProperty: "category")
                mapping.mapKeyPath("promo", toProperty: "promo")
        })
    }
}

class HydroCategoryModel: NSObject, EKMappingProtocol {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var type = ""
    @objc dynamic var subCategoryList = [HydroSubCategoryModel]()
    
    static func objectMapping() -> EKObjectMapping {
        return EKObjectMapping(
            for: self,
            with: {(mapping) in
                mapping.mapKeyPath("name", toProperty: "name")
                mapping.mapKeyPath("cat_id", toProperty: "id")
                mapping.mapKeyPath("type", toProperty: "type")
                mapping.hasMany(HydroSubCategoryModel.self, forKeyPath: "sub_cats", forProperty: "subCategoryList")
        })
    }
    
}

class HydroHistoryCategoryModel: NSObject, EKMappingProtocol {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var subCategoryList = [HydroSubCategoryModel]()
    
    static func objectMapping() -> EKObjectMapping {
        return EKObjectMapping(
            for: self,
            with: {(mapping) in
                mapping.mapKeyPath("cat_name", toProperty: "name")
                mapping.mapKeyPath("cat_id", toProperty: "id")
                mapping.hasMany(HydroSubCategoryModel.self, forKeyPath: "hydro_cat", forProperty: "subCategoryList")
        })
    }
    
}

class HydroSubCategoryModel: NSObject, EKMappingProtocol {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var info = ""
    @objc dynamic var addonPriceTotal = ""
    @objc dynamic var price = 0
    @objc dynamic var addOnQty = 0
    @objc dynamic var extraPrice = 0
    @objc dynamic var lessOudorExtraPrice = 0
    @objc dynamic var rejunevationExtraPrice = 0
    @objc dynamic var sensibioExtraPrice = 0
    @objc dynamic var isLessodour: Bool = false
    @objc dynamic var isRejuvenation: Bool = false
    @objc dynamic var isSensibio: Bool = false
    @objc dynamic var isBagasi: Bool = false
    
    static func objectMapping() -> EKObjectMapping {
        return EKObjectMapping(
            for: self,
            with: {(mapping) in
                mapping.mapKeyPath("sub_cat_id", toProperty: "id")
                mapping.mapKeyPath("sub_cat_name", toProperty: "name")
                mapping.mapKeyPath("sub_cat_price", toProperty: "price")
                mapping.mapKeyPath("sub_cat_extra_price", toProperty: "extraPrice")
                mapping.mapKeyPath("is_lessodour", toProperty: "isLessodour")
                mapping.mapKeyPath("extra_price_lessodour", toProperty: "lessOudorExtraPrice")
                mapping.mapKeyPath("is_rejuvenation", toProperty: "isRejuvenation")
                mapping.mapKeyPath("extra_price_rejuvenation", toProperty: "rejunevationExtraPrice")
                mapping.mapKeyPath("is_sensibio", toProperty: "isSensibio")
                mapping.mapKeyPath("extra_price_sensibio", toProperty: "sensibioExtraPrice")
                mapping.mapKeyPath("is_bagasi", toProperty: "isBagasi")
                mapping.mapKeyPath("addon_qty", toProperty: "addOnQty")
                mapping.mapKeyPath("info", toProperty: "info")
                mapping.mapKeyPath("addon_price_total", toProperty: "addonPriceTotal")
        })
    }
    
}
