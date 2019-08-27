//
//  TransactionDetailModel.swift
//  AYO CLEAN
//
//  Created by ABDUL AZIS H on 28/07/18.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import EasyMapping

class TransactionDetailAddOnnModel: NSObject, EKMappingProtocol {
    @objc dynamic var addOn = [TransactionAddOn]()
    
    static func objectMapping() -> EKObjectMapping {
        return EKObjectMapping(
            for: self,
            with: {(mapping) in
                mapping.hasMany(TransactionAddOn.self, forKeyPath: "addon", forProperty: "addOn")
        })
    }
}

class TransactionDetailModel: NSObject, EKMappingProtocol {
    @objc dynamic var id = ""
    @objc dynamic var cleanerImage = ""
    @objc dynamic var type = ""
    @objc dynamic var date = ""
    @objc dynamic var time = ""
    @objc dynamic var address = ""
    @objc dynamic var note = ""
    @objc dynamic var paymentMethod = ""
    @objc dynamic var promo = ""
    @objc dynamic var totalPrice = ""
    @objc dynamic var orderTotalPrice = ""
    @objc dynamic var number = ""
    @objc dynamic var paymentStatus = ""
    @objc dynamic var preferensi = ""
    @objc dynamic var customerName = ""
    @objc dynamic var orderTTd = ""
    @objc dynamic var duration = ""
    @objc dynamic var durationPrice = ""
    @objc dynamic var discount = ""
    @objc dynamic var alasanPembatalan = ""
    @objc dynamic var cleanerName = ""
    @objc dynamic var promoCode = ""
    @objc dynamic var orderStatus = [String]()
    @objc dynamic var category = [HydroHistoryCategoryModel]()
    @objc dynamic var addOn = [TransactionAddOn]()
    
    static func objectMapping() -> EKObjectMapping {
        return EKObjectMapping(
            for: self,
            with: {(mapping) in
                mapping.mapKeyPath("order_id", toProperty: "id")
                mapping.mapKeyPath("order_type", toProperty: "type")
                mapping.mapKeyPath("order_date", toProperty: "date")
                mapping.mapKeyPath("order_time", toProperty: "time")
                mapping.mapKeyPath("order_address", toProperty: "address")
                mapping.mapKeyPath("order_note", toProperty: "note")
                mapping.mapKeyPath("payment_method", toProperty: "paymentMethod")
                mapping.mapKeyPath("order_promo", toProperty: "promo")
                mapping.mapKeyPath("payment_method", toProperty: "paymentMethod")
                mapping.mapKeyPath("total_price", toProperty: "totalPrice")
                mapping.mapKeyPath("order_total_price", toProperty: "orderTotalPrice")
                mapping.mapKeyPath("order_no", toProperty: "number")
                mapping.mapKeyPath("payment_status", toProperty: "paymentStatus")
                mapping.mapKeyPath("order_preferensi", toProperty: "preferensi")
                mapping.mapKeyPath("customer_name", toProperty: "customerName")
                mapping.mapKeyPath("order_ttd", toProperty: "orderTTd")
                mapping.mapKeyPath("order_duration", toProperty: "duration")
                mapping.mapKeyPath("order_price_per_hour", toProperty: "durationPrice")
                mapping.mapKeyPath("discount_nominal", toProperty: "discount")
                mapping.mapKeyPath("alasan_pembatalan", toProperty: "alasanPembatalan")
                mapping.mapKeyPath("order_status", toProperty: "orderStatus")
                mapping.mapKeyPath("cleaner_img", toProperty: "cleanerImage")
                mapping.mapKeyPath("cleaner_name", toProperty: "cleanerName")
                mapping.mapKeyPath("promo_code", toProperty: "promoCode")
                mapping.hasMany(HydroHistoryCategoryModel.self, forKeyPath: "hydro_cat", forProperty: "category")
        })
    }
}

class TransactionAddOn: NSObject, EKMappingProtocol {
    @objc dynamic var orderAddonId = ""
    @objc dynamic var addonDurationTotal = ""
    @objc dynamic var orderId = ""
    @objc dynamic var addonName = ""
    @objc dynamic var addonPriceTotal = ""
    @objc dynamic var updatedAt = ""
    @objc dynamic var createdAt = ""
    @objc dynamic var addonPriceEach = ""
    @objc dynamic var addonQty = ""
    @objc dynamic var addonDurationEach = ""
    @objc dynamic var addonId = ""
    
    static func objectMapping() -> EKObjectMapping {
        return EKObjectMapping(
            for: self,
            with: {(mapping) in
                mapping.mapKeyPath("order_addon_id", toProperty: "orderAddonId")
                mapping.mapKeyPath("addon_duration_total", toProperty: "addonDurationTotal")
                mapping.mapKeyPath("order_id", toProperty: "orderId")
                mapping.mapKeyPath("addon_name", toProperty: "addonName")
                mapping.mapKeyPath("addon_price_total", toProperty: "addonPriceTotal")
                mapping.mapKeyPath("updated_at", toProperty: "updatedAt")
                mapping.mapKeyPath("created_at", toProperty: "createdAt")
                mapping.mapKeyPath("addon_price_each", toProperty: "addonPriceEach")
                mapping.mapKeyPath("addon_qty", toProperty: "addonQty")
                mapping.mapKeyPath("addon_duration_each", toProperty: "addonDurationEach")
                mapping.mapKeyPath("addon_id", toProperty: "addonId")
        })
    }
    
}
