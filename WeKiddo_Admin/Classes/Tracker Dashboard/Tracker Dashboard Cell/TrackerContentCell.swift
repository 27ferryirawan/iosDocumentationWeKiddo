//
//  TrackerContentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 21/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol TrackerContentCellDelegate: class {
    func toDetailPage(withIndex: Int)
}

class TrackerContentCell: UITableViewCell {

    @IBOutlet weak var worksheetView: UIView! {
        didSet {
            worksheetView.layer.cornerRadius = worksheetView.frame.size.width / 2
            worksheetView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var rightView: UIView! {
        didSet {
            rightView.layer.borderColor = UIColor.lightGray.cgColor
            rightView.layer.borderWidth = 1.0
            rightView.layer.cornerRadius = 5.0
            rightView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var averageView: UIView! {
        didSet {
            averageView.layer.cornerRadius = averageView.frame.size.width / 2
            averageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var leftView: UIView! {
        didSet {
            leftView.layer.borderColor = UIColor.lightGray.cgColor
            leftView.layer.borderWidth = 1.0
            leftView.layer.cornerRadius = 5.0
            leftView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.borderColor = UIColor.lightGray.cgColor
            bgView.layer.borderWidth = 1.0
            bgView.layer.cornerRadius = 5.0
            bgView.layer.masksToBounds = true
        }
    }
    
    weak var delegate: TrackerContentCellDelegate?
    var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func toDetailAction(_ sender: Any) {
        self.delegate?.toDetailPage(withIndex: index)
    }
    
}
