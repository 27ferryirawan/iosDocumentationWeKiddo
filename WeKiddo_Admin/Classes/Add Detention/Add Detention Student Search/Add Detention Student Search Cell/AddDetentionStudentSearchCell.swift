//
//  AddDetentionStudentSearchCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 09/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

protocol AddDetentionStudentSearchCellDelegate: class {
    func refreshData(withIndex: Int, withChildID: String)
    func deleteData(withIndex: Int, withChildID: String)
}

class AddDetentionStudentSearchCell: UITableViewCell {

    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var studentNIS: UILabel!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentImage: UIImageView!
    var isClicked = Bool()
    var studentLists = [StudentSearchSelected]()
    var index = 0
    var studentObj: StudentSearchModel? {
        didSet {
            cellConfig()
        }
    }
    weak var delegate: AddDetentionStudentSearchCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        checkBoxButton.addTarget(self, action: #selector(checkBoxClicked), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func checkBoxClicked() {
        guard let obj = studentObj else { return }
        if !isClicked {
            isClicked = true
            checkBoxButton.setBackgroundImage(UIImage(named: "radio-on-button"), for: .normal)
            self.delegate?.refreshData(withIndex: index, withChildID: obj.child_id)
        } else {
            isClicked = false
            checkBoxButton.setBackgroundImage(UIImage(named: "circumference"), for: .normal)
            self.delegate?.deleteData(withIndex: index, withChildID: obj.child_id)
        }
    }
    func cellConfig() {
        let placeData = UserDefaults.standard.data(forKey: "studentSelected")
        let placeArray = try! JSONDecoder().decode([StudentSearchSelected].self, from: placeData!)
        studentLists = placeArray

        guard let obj = studentObj else { return }
        studentImage.sd_setImage(
            with: URL(string: (obj.child_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        studentName.text = obj.child_name
        studentNIS.text = obj.school_class
        print(studentLists)
        for (index, item) in studentLists.enumerated() {
            print("\(item.child_id) <----> \(obj.child_id)")
            if item.child_id == obj.child_id {
                isClicked = true
                checkBoxButton.setBackgroundImage(UIImage(named: "radio-on-button"), for: .normal)
            } else {
                isClicked = false
                checkBoxButton.setBackgroundImage(UIImage(named: "circumference"), for: .normal)
            }
        }
    }
}
