//
//  AgendaTopicCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 20/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class AgendaTopicCell: UITableViewCell {

    @IBOutlet weak var dividerView: UIView!{
        didSet{
            dividerView.isHidden = false
        }
    }
    @IBOutlet weak var agendaNameLbl: UILabel!
    @IBOutlet weak var agendaTypeColor: UIView!
    var agendaTopicObj: AgendaModel?{
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = agendaTopicObj else {
            return
        }
        agendaNameLbl.text = obj.agendaName
    }
}
