//
//  AddSubjectTeacherSessionCell.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 14/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

protocol AddSubjectTeacherSessionCellDelegate: class {
    func sessionArrayCollected(withArray: [SubjectTeacherSessionSelectedModel])
    func sessionWeekAdded(data: SubjectTeacherDetailSessionWeekModel)
}

class AddSubjectTeacherSessionCell: UITableViewCell {
    
    @IBOutlet weak var sessionCollection: UICollectionView! {
        didSet {
            sessionCollection.layer.borderColor = UIColor.lightGray.cgColor
            sessionCollection.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var selectWeekButtonPicker: UIButton! {
        didSet {
            selectWeekButtonPicker.layer.borderColor = UIColor.lightGray.cgColor
            selectWeekButtonPicker.layer.borderWidth = 1.0
        }
    }
    var detailObj: SubjectTeacherParamModel? {
        didSet {
            cellConfig()
        }
    }
    var detailEditObj: SubjectTeacherDetailSessionWeekModel? {
        didSet {
            cellConfigEdit()
        }
    }
    var currentSession = 0
    var currentIndexPath = 0
    var currentSection = 0
    var selectedIndex = -1
    var isFromEdit = false
    var weekArray = [String]()
    var sessionArray = [String]()
    var sessionSelected = [SubjectTeacherSessionSelectedModel]()
    weak var delegate: AddSubjectTeacherSessionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectWeekButtonPicker.addTarget(self, action: #selector(showWeekPicker), for: .touchUpInside)
        sessionCollection.register(UINib(nibName: "AddSubjectTeacherSessionCollectionCell", bundle: nil), forCellWithReuseIdentifier: "addSubjectTeacherSessionCollectionCellID")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfigEdit() {
        guard let obj = detailEditObj else { return }
        let titleWeek = "Week \(obj.week_count) (\(obj.from_date) - \(obj.end_date))"
        self.selectWeekButtonPicker.setTitle(titleWeek, for: .normal)
        self.sessionArray.removeAll()
        for (index, item) in obj.sessions.enumerated() {
            self.sessionArray.append("Session \(item.session_count)")
            if item.is_checked {
                if let _ = sessionSelected.first(where: { $0.valueAt == "\(item.session_count)" }) {
                    
                } else {
                    print("\(item.session_count) week = \(index)")
                    sessionSelected.append(SubjectTeacherSessionSelectedModel(sectionAt: currentIndexPath - 1, indexAt: index, valueAt: "\(item.session_count)"))
                }
            }
        }
        self.delegate?.sessionArrayCollected(withArray: sessionSelected)
        self.sessionCollection.reloadData()
    }
    func cellConfig() {
        let title = (currentIndexPath == -1 || weekArray.count <= currentIndexPath) ? "Select Week" : weekArray[currentIndexPath]
        self.selectWeekButtonPicker.setTitle(title, for: .normal)
        weekArray.removeAll()
        guard let obj = detailObj else { return }
        for item in obj.week_session {
            weekArray.append("Week \(item.week_count) (\(getMonth(time: item.from_date)) - \(getMonth(time: item.end_date)))")
        }
        self.sessionCollection.reloadData()
    }
    @objc func showWeekPicker() {
        guard let obj = detailObj else { return }
        ActionSheetStringPicker.show(
            withTitle: "- Select Week -",
            rows: weekArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.selectWeekButtonPicker.setTitle(value, for: .normal)
                self.sessionCollection.isHidden = false
                self.selectedIndex = indexes
                self.sessionArray.removeAll()
                
                let source = obj.week_session[indexes]
                let data = SubjectTeacherDetailSessionWeekModel()
                data.from_date = source.from_date
                
                for item in obj.week_session[indexes].sessions {
                    if self.isFromEdit{
                        let newSeason = SubjectTeacherDetailSessionWeekSessionListModel()
                        newSeason.session_count = item.session_count
                        newSeason.is_checked = false
                        newSeason.week_count = source.week_count
                        data.sessions.append(newSeason)
                    } else {
                        self.sessionArray.append("Session \(item.session_count)")
                    }
                }
                
                data.end_date = source.end_date
                data.week_count = source.week_count
                self.delegate?.sessionWeekAdded(data: data)
                self.sessionCollection.reloadData()
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
}

extension AddSubjectTeacherSessionCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentIndexPath == -1 ? 0 : sessionArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "addSubjectTeacherSessionCollectionCellID", for: indexPath) as? AddSubjectTeacherSessionCollectionCell)!
        if isFromEdit {
            if sessionSelected.contains(where: {$0.indexAt == indexPath.row && $0.sectionAt == currentSection}) {
                cell.sessionImageStatus.image = UIImage(named: "radio-on-button")
            } else {
                cell.sessionImageStatus.image = UIImage(named: "circumference")
            }
            
            if let obj = detailEditObj {
                cell.detailEditObj = obj.sessions[indexPath.row]
            }
            cell.section = currentSection
            cell.index = indexPath.row
        } else {
            cell.sessionSelected = self.sessionSelected
            if sessionSelected.contains(where: {$0.indexAt == indexPath.row && $0.sectionAt == currentSection}) {
                cell.sessionImageStatus.image = UIImage(named: "radio-on-button")
            } else {
                cell.sessionImageStatus.image = UIImage(named: "circumference")
            }
            
            if let obj = detailObj, selectedIndex != -1 {
                cell.detailObj = obj.week_session[selectedIndex].sessions[indexPath.row]
            }
            cell.section = self.currentSection
            cell.index = indexPath.row
        }
        cell.delegate = self
        return cell
    }
}

extension AddSubjectTeacherSessionCell: AddSubjectTeacherSessionCollectionCellDelegate {
    func sessionClickedAt(section: Int, index: Int) {
        print("section: \(section), index: \(index)")
        if isFromEdit {
            guard let obj = detailEditObj else { return }
            if sessionSelected.count == 0 {
                sessionSelected.append(SubjectTeacherSessionSelectedModel(sectionAt: section, indexAt: index, valueAt: "\(obj.sessions[index].session_count)"))
                print(sessionSelected)
                sessionCollection.reloadData()
                self.delegate?.sessionArrayCollected(withArray: sessionSelected)
            } else {
                if sessionSelected.contains(where: {$0.indexAt == index && $0.sectionAt == section}) {
                    if let index = sessionSelected.index(where: {$0.indexAt == index && $0.sectionAt == section}) {
                        sessionSelected.remove(at: index)
                    }
                    print(sessionSelected)
                    sessionCollection.reloadData()
                    self.delegate?.sessionArrayCollected(withArray: sessionSelected)
                } else {
                    sessionSelected.append(SubjectTeacherSessionSelectedModel(sectionAt: section, indexAt: index, valueAt: "\(obj.sessions[index].session_count)"))
                    print(sessionSelected)
                    sessionCollection.reloadData()
                    self.delegate?.sessionArrayCollected(withArray: sessionSelected)
                }
            }
        } else {
            guard let obj = detailObj else { return }
            if sessionSelected.count == 0 {
                sessionSelected.append(SubjectTeacherSessionSelectedModel(sectionAt: section, indexAt: index, valueAt: "\(obj.week_session[selectedIndex].sessions[index].session_count)"))
                print(sessionSelected)
                sessionCollection.reloadData()
                self.delegate?.sessionArrayCollected(withArray: sessionSelected)
            } else {
                if sessionSelected.contains(where: {$0.indexAt == index && $0.sectionAt == section}) {
                    if let index = sessionSelected.index(where: {$0.indexAt == index && $0.sectionAt == section}) {
                        sessionSelected.remove(at: index)
                    }
                    print(sessionSelected)
                    sessionCollection.reloadData()
                    self.delegate?.sessionArrayCollected(withArray: sessionSelected)
                } else {
                    sessionSelected.append(SubjectTeacherSessionSelectedModel(sectionAt: section, indexAt: index, valueAt: "\(obj.week_session[selectedIndex].sessions[index].session_count)"))
                    print(sessionSelected)
                    sessionCollection.reloadData()
                    self.delegate?.sessionArrayCollected(withArray: sessionSelected)
                }
            }
        }
    }
}

extension AddSubjectTeacherSessionCell {
    func getMonth(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        // then convert date to string again
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "dd MMM yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
