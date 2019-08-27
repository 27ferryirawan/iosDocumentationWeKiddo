//
//  SearchAssignmentCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 12/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class SearchAssignmentCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func goToSessionDetail(_ sender: UIButton) {
        // TODO: Fetch session detail and go to detail page
    }
    
}
