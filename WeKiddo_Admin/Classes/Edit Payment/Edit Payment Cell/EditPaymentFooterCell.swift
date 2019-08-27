//
//  EditPaymentFooterCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 28/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol EditPaymentFooterCellDelegate: class {
    func savePayment()
}

class EditPaymentFooterCell: UITableViewCell {

    @IBOutlet weak var saveButton: UIButton!
    weak var delegate: EditPaymentFooterCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        saveButton.addTarget(self, action: #selector(saveEventPayment), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func saveEventPayment() {
        self.delegate?.savePayment()
    }
}
