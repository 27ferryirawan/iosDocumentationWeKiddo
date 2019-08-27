//
//  ProductModel.swift
//  AYO CLEAN
//
//  Created by ABDUL AZIS H on 18/07/18.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import EasyMapping

class ProductModel: NSObject, EKMappingProtocol {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var type = ""
    @objc dynamic var price = 0
    
    convenience init(id: Int, name: String, type: String, price: Int) {
        self.init()
        self.id = id
        self.name = name
        self.type = type
        self.price = price
    }
    
    static func objectMapping() -> EKObjectMapping {
        return EKObjectMapping(
            for: self,
            with: {(mapping) in
                mapping.mapProperties(from:
                    ["id",
                     "name",
                     "type",
                     "price"
                    ])
        })
    }
    
}
