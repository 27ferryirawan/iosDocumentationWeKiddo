//
//  FutureHeaderCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 14/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol FutureHeaderDelegate: class {
    func getAcademic()
    func getTalent()
    func getCareer()
}

class FutureHeaderCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var backToCareerButton: UIButton!
    @IBOutlet weak var academyButton: UIButton!
    @IBOutlet weak var talentButton: UIButton!
    var isCareer = false
    var isAcademy = false
    weak var delegate: FutureHeaderDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func config() {
        if isCareer {
            contentLabel.text = "Career"
            backToCareerButton.isHidden = true
        } else {
            if isAcademy {
                contentLabel.text = "Choose Your Academic"
            } else {
                contentLabel.text = "Choose Your Talent"
            }
            backToCareerButton.isHidden = false
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func academyClicked(_ sender: Any) {
        self.delegate?.getAcademic()
    }
    @IBAction func talentClicked(_ sender: Any) {
        self.delegate?.getTalent()
    }
    @IBAction func backToCareerClicked(_ sender: Any) {
        self.delegate?.getCareer()
    }
}
