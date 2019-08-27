//
//  TransactionHistory.swift
//  AYO CLEAN
//
//  Created by ABDUL AZIS H on 19/07/18.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import EasyMapping

class TransactionHistoryList: NSObject, EKMappingProtocol{
    @objc dynamic var hydroData = [TransactionHistoryModel]()
    @objc dynamic var tidyData = [TransactionHistoryModel]()
    @objc dynamic var orderData = [TransactionHistoryModel]()
    @objc dynamic var historyData = [TransactionHistoryModel]()
    
    static func objectMapping() -> EKObjectMapping {
        return EKObjectMapping(
            for: self,
            with: {(mapping) in
                mapping.hasMany(TransactionHistoryModel.self, forKeyPath: "orders_tidy", forProperty: "tidyData")
                mapping.hasMany(TransactionHistoryModel.self, forKeyPath: "orders_hydro", forProperty: "hydroData")
                mapping.hasMany(TransactionHistoryModel.self, forKeyPath: "list_orders", forProperty: "orderData")
                mapping.hasMany(TransactionHistoryModel.self, forKeyPath: "list_histories", forProperty: "historyData")
        })
    }
}

class TransactionHistoryModel: NSObject, EKMappingProtocol {
    @objc dynamic var order_id = ""
    @objc dynamic var order_date = ""
    @objc dynamic var order_time = ""
    @objc dynamic var order_address = ""
    @objc dynamic var order_no = ""
    @objc dynamic var order_type = ""
    @objc dynamic var durasi_barang = ""
    @objc dynamic var order_cleaner_name = ""
    @objc dynamic var order_status = ""
    @objc dynamic var order_rating = ""
    
    static func objectMapping() -> EKObjectMapping {
        return EKObjectMapping(
            for: self,
            with: {(mapping) in
                mapping.mapProperties(from:
                    ["order_id",
                     "order_date",
                     "order_time",
                     "order_address",
                     "order_no",
                     "order_type",
                     "durasi_barang",
                     "order_cleaner_name",
                     "order_status",
                     "order_rating"
                    ])
        })
    }
    
}
