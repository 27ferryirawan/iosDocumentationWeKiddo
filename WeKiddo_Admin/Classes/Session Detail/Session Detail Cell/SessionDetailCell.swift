//
//  SessionDetailCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 06/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol SessionDetailCellDelegate: class {
    func toStudentNote()
}

class SessionDetailCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var subjectDesc: UILabel!
    @IBOutlet weak var subjectTeacher: UILabel!
    @IBOutlet weak var subjectDate: UILabel!
    @IBOutlet weak var subjectName: UILabel!
    @IBOutlet weak var subjectChapter: UILabel!
    @IBOutlet weak var subjectImage: UIImageView!
    @IBOutlet weak var subjectTitle: UIButton!
    @IBOutlet weak var collectionMenuCell: UICollectionView!
    @IBOutlet weak var contentLabel: UILabel! {
        didSet {
            contentLabel.sizeToFit()
        }
    }
    weak var delegate: SessionDetailCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionMenuCell.register(UINib(nibName: "SessionMenuCollectionCell", bundle: nil), forCellWithReuseIdentifier: "sessionMenuCollectionCell")
        collectionMenuCell.dataSource = self
        collectionMenuCell.delegate = self
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func config() {
        guard let obj = ACData.SESSIONDETAIL else {
            return
        }
        subjectTitle.setTitle(obj.subject_name, for: .normal)
        subjectChapter.text = obj.chapter_id
        subjectName.text = obj.subject_session
        subjectDesc.text = obj.subject_session_desc
        subjectDate.text = "\(convertDate(time: obj.class_session_start)) \(toDateString(time: obj.class_session_start)) - \(toDateString(time: obj.class_session_end)) PM"
        subjectTeacher.text = obj.teacher_name
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sessionMenuCollectionCell", for: indexPath as IndexPath) as! SessionMenuCollectionCell
        if indexPath.row == 0 {
            cell.menuLabel.text = "Attachment"
            cell.menuIconImage.image = UIImage(named: "ic_attach")
        } else {
            cell.menuLabel.text = "Student Note"
            cell.menuIconImage.image = UIImage(named: "icon_note")
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            // TODO: to attachment page
        } else {
            self.delegate?.toStudentNote()
        }
    }
}

extension SessionDetailCell {
    func convertDate(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        // then convert date to string again
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "dd MMMM yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
    func toDateString(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-mm-dd hh:mm:ss"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        // then convert date to string again
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "HH:mm"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
