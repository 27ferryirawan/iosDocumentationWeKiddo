//
//  ReceiverCollectionCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 04/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class ReceiverCollectionCell: UICollectionViewCell {

    @IBOutlet weak var contentText: UITextField!
    var detailObj: DetailTicketChatModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        contentText.text = obj.chat_msg
    }
}
