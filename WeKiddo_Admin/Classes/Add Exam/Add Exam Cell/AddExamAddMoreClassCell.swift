//
//  AddExamAddMoreClassCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 25/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol AddExamAddMoreClassCellDelegate: class {
    func addNewMoreClass()
}

class AddExamAddMoreClassCell: UITableViewCell {

    @IBOutlet weak var addMoreClassButton: UIButton!
    weak var delegate: AddExamAddMoreClassCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        addMoreClassButton.addTarget(self, action: #selector(addMoreClass), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func addMoreClass() {
        self.delegate?.addNewMoreClass()
    }
}
