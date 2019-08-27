//
//  TeacherOnDutyCell.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 12/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import Hex
import ActionSheetPicker_3_0
import SVProgressHUD

protocol TeacherOnDutyDelegate : class{
    func popUp(indexPath: Int, child_image:String, child_name:String, early_leave:Int, late_info:Int, child_id:String)
    func showAlert(withMessage: String)
    func classPickerID(classID : String)
}

class TeacherOnDutyCell: UITableViewCell{
    
    weak var delegate : TeacherOnDutyDelegate?
   
    @IBOutlet weak var selectClassPicker: UIButton!
    @IBOutlet weak var classLbl: UILabel!{
        didSet{
            classLbl.isHidden = true
        }
    }
    @IBOutlet weak var teacherLbl: UILabel!{
        didSet{
            teacherLbl.isHidden = true
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    var collectionDataCount = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        classLbl.isHidden = true
        teacherLbl.isHidden = true
        selectClassPicker.addTarget(self, action: #selector(showClassPicker), for: .touchUpInside)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "StudentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "studentCollectionViewCell")
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    var className = [String]()
    var classID = ""
    var schoolObj: TeacherOnDutyChildListModel? {
        didSet {
            cellDataSet()
        }
    }
    func cellDataSet() {
        guard let obj = schoolObj else {
            return
        }
        classLbl.isHidden = false
        teacherLbl.isHidden = false
        classLbl.text = obj.school_class
        teacherLbl.text = obj.teacher_name
        collectionDataCount = obj.class_info.count
        collectionView.reloadData()
    }
    var object: TeacherOnDutyChildListPickerModel? {
        didSet {
            cellConfig()
        }
    }
    func cellConfig() {
        guard let obj = object else { return }
        for item in obj.class_picker {
            className.append(item.school_class)
        }
    }
    @objc func showClassPicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Class -",
            rows: className,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.selectClassPicker.setTitle(value, for: .normal)
                self.classID = ACData.TEACHERONDUTYPICKERDATA.class_picker[indexes].school_class_id
                self.delegate?.classPickerID(classID: self.classID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
        className.removeAll()
        classID.removeAll()
    }
}
extension TeacherOnDutyCell : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionDataCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "studentCollectionViewCell", for: indexPath) as? StudentCollectionViewCell)!
        cell.childObjc = ACData.TEACHERONDUTYGETLISTDATA.class_info[indexPath.row]
//        cell.configCell(index: indexPath.row)
//        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.popUp(indexPath: indexPath.row, child_image:ACData.TEACHERONDUTYGETLISTDATA.class_info[indexPath.row].child_image, child_name:ACData.TEACHERONDUTYGETLISTDATA.class_info[indexPath.row].child_name, early_leave:ACData.TEACHERONDUTYGETLISTDATA.class_info[indexPath.row].early_leave, late_info:ACData.TEACHERONDUTYGETLISTDATA.class_info[indexPath.row].late_info, child_id: ACData.TEACHERONDUTYGETLISTDATA.class_info[indexPath.row].child_id)
    }
}
