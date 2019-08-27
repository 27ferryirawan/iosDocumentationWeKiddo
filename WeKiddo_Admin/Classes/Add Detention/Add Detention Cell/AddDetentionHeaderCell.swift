//
//  AddDetentionHeaderCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 09/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol AddDetentionHeaderCellDelegate: class {
    func toSearchStudentPage(withStudentsLists: [StudentSearchSelected])
}

class AddDetentionHeaderCell: UITableViewCell {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    weak var delegate: AddDetentionHeaderCellDelegate?
    var studentLists = [StudentSearchSelected]()
    override func awakeFromNib() {
        super.awakeFromNib()
        searchButton.addTarget(self, action: #selector(toSearch), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func toSearch() {
        self.delegate?.toSearchStudentPage(withStudentsLists: studentLists)
    }
}
