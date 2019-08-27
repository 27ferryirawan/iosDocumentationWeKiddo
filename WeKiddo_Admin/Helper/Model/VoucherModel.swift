//
//  VoucherModel.swift
//  AYO CLEAN
//
//  Created by zein rezky chandra on 08/07/18.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import EasyMapping

class VoucherModelList: NSObject, EKMappingProtocol{
    @objc dynamic var voucher = [VoucherModel]()
    
    static func objectMapping() -> EKObjectMapping {
        return EKObjectMapping(
            for: self,
            with: {(mapping) in
                mapping.hasMany(VoucherModel.self, forKeyPath: "promo", forProperty: "voucher")
        })
    }
}

class VoucherModel: NSObject, EKMappingProtocol{
    @objc dynamic var promo_id = ""
    @objc dynamic var slug = ""
    @objc dynamic var title = ""
    @objc dynamic var diskon_persen = ""
    @objc dynamic var kode_promo = ""
    @objc dynamic var link_promo = ""
    @objc dynamic var image_thumbnail = ""
    @objc dynamic var image_detail = ""
    
    convenience init(promo_id:String, slug:String, title:String, diskon_persen:String, kode_promo:String, link_promo:String, image_thumbnail:String, image_detail:String) {
        self.init()
        self.promo_id = promo_id
        self.slug = slug
        self.title = title
        self.diskon_persen = diskon_persen
        self.kode_promo = kode_promo
        self.link_promo = link_promo
        self.image_detail = image_detail
        self.image_thumbnail = image_thumbnail
    }
    
    static func objectMapping() -> EKObjectMapping {
        return EKObjectMapping(
            for: self,
            with: {(mapping) in
                mapping.mapProperties(from:
                    [
                        "promo_id",
                        "slug",
                        "title",
                        "diskon_persen",
                        "kode_promo",
                        "link_promo",
                        "image_thumbnail",
                        "image_detail"
                    ])
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//                mapping.mapKeyPath("news_date", toProperty: "news_date", with: dateFormatter)
        })
    }
}
