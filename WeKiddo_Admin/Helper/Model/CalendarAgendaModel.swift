//
//  CalendarAgendaModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 23/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class CalendarAgendaModel: NSObject {
    var date = ""
    var agendas = [AgendaModel]()
    
    func objectMapping(json: JSON) {
        date = json["date"].stringValue
        
        for data in json["agenda_item"].arrayValue {
            let d = AgendaModel()
            d.objectMapping(json: data)
            agendas.append(d)
        }
    }
}

class AgendaModel: NSObject {
    var agendaId = ""
    var agendaName = ""
    var agendaType = ""

    func objectMapping(json: JSON) {
        agendaId = json["id"].stringValue
        agendaName = json["name"].stringValue
        agendaType = json["type"].stringValue
    }
}
