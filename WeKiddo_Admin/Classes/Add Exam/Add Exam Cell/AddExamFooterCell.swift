//
//  AddExamFooterCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 25/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

protocol AddExamFooterCellDelegate: class {
    func sessionArrayCollected(withArray: [ExamSessionSelectedModel])
}

class AddExamFooterCell: UITableViewCell {

    @IBOutlet weak var weekSessionButton: UIButton!
    @IBOutlet weak var sessionCollection: UICollectionView!
    var weekArray = [String]()
    var sessionArray = [String]()
    var selectedIndex = 0
    var currentWeek = 0
    var sessionSelected = [ExamSessionSelectedModel]()
    weak var delegate: AddExamFooterCellDelegate?
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color: UIColor.lightGray, shadowRadius: 2.0, shadowOpactiy: 1.0, shadowOffsetWidth: 2, shadowOffsetHeight: 2)
        }
    }
    var detailObj: ExamMajorModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        sessionCollection.register(UINib(nibName: "AddExamSessionCell", bundle: nil), forCellWithReuseIdentifier: "addExamSessionCellID")
        weekSessionButton.addTarget(self, action: #selector(showWeekSessionPicker), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func showWeekSessionPicker() {
        guard let obj = detailObj else { return }
        ActionSheetStringPicker.show(
            withTitle: "- Select Week -",
            rows: weekArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.weekSessionButton.setTitle(value, for: .normal)
                self.selectedIndex = indexes
                self.currentWeek = obj.week_session[indexes].week_count
                self.sessionCollection.isHidden = false
                self.sessionArray.removeAll()
                for item in obj.week_session[indexes].sessions {
                    self.sessionArray.append("Session \(item.session_count)")
                }
                self.sessionCollection.reloadData()
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        weekArray.removeAll()
        for item in obj.week_session {
            weekArray.append("Week \(item.week_count) (\(getMonth(time: item.from_date)) - \(getMonth(time: item.end_date)))")
        }
    }
}

extension AddExamFooterCell {
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

extension AddExamFooterCell: UICollectionViewDelegate, UICollectionViewDataSource, AddExamSessionCellDelegate {
    func sessionClickedAt(week: Int, session: Int) {
//        guard let obj = detailObj else { return }
        if sessionSelected.count == 0 {
            sessionSelected.append(ExamSessionSelectedModel(weekAt: week, sessionAt: session))
            print(sessionSelected)
            sessionCollection.reloadData()
            self.delegate?.sessionArrayCollected(withArray: sessionSelected)
        } else {
            if sessionSelected.contains(where: {$0.weekAt == week && $0.sessionAt == session}) {
                if let index = sessionSelected.index(where: {$0.weekAt == week && $0.sessionAt == session}) {
                    sessionSelected.remove(at: index)
                }
                print(sessionSelected)
                sessionCollection.reloadData()
                self.delegate?.sessionArrayCollected(withArray: sessionSelected)
            } else {
                sessionSelected.append(ExamSessionSelectedModel(weekAt: week, sessionAt: session))
                print(sessionSelected)
                sessionCollection.reloadData()
                self.delegate?.sessionArrayCollected(withArray: sessionSelected)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sessionArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "addExamSessionCellID", for: indexPath) as? AddExamSessionCell)!
//        cell.sessionSelected = self.sessionSelected
        if sessionSelected.contains(where: {$0.weekAt == currentWeek && $0.sessionAt == ACData.EXAMMAJORLISTDATA.week_session[selectedIndex].sessions[indexPath.row].session_count}) {
            cell.sessionImageStatus.image = UIImage(named: "radio-on-button")
            print(sessionSelected)
        } else {
            cell.sessionImageStatus.image = UIImage(named: "circumference")
            print(sessionSelected)
        }
//
        if let obj = detailObj {
            cell.detailObj = obj.week_session[selectedIndex].sessions[indexPath.row]
        }
        cell.currentWeek = self.currentWeek
//        cell.index = indexPath.row
        cell.delegate = self
        return cell
    }
}
