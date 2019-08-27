//
//  AttendanceDetailViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 27/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD
import ActionSheetPicker_3_0

class AttendanceDetailViewController: UIViewController {
    
    var reasonArray = ["Sick", "Leave", "Alpha"]
    var reasonSelected = 0
    var childIndex = ""
    var notes = ""
    var childAttendStatus = Bool()
    @IBOutlet weak var reasonIconImage: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var noteText: UITextView!
    @IBOutlet weak var reasonButton: UIButton!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentImage: UIImageView!
    @IBOutlet weak var closeStudentViewButton: UIButton!
    @IBOutlet weak var studentView: UIView! {
        didSet {
            studentView.layer.borderWidth = 0.5
            studentView.layer.borderColor = ACColor.MAIN.cgColor
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var approvalIcon: UIImageView!
    @IBOutlet weak var approvalButton: UIButton! {
        didSet {
            approvalButton.layer.borderWidth = 0.5
            approvalButton.layer.borderColor = ACColor.MAIN.cgColor
        }
    }
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var headerView: UIView! {
        didSet {
            headerView.setBorderShadow(color:  UIColor.gray, shadowRadius: 3.0, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    @IBOutlet weak var bgBorderView: UIView! {
        didSet {
            bgBorderView.setBorderShadow(color:  UIColor.gray, shadowRadius: 3.0, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        populateData()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Attendance Detail", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        approvalButton.addTarget(self, action: #selector(approveAction), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        closeStudentViewButton.addTarget(self, action: #selector(closeStudentView), for: .touchUpInside)
        reasonButton.addTarget(self, action: #selector(showReasonPicker), for: .touchUpInside)
        collectionView.register(UINib(nibName: "AttendanceUserCell", bundle: nil), forCellWithReuseIdentifier: "attendanceUserCellID")
        self.reasonButton.setTitle("Reason", for: .normal)
        studentView.isHidden = true
    }
    func populateData() {
        guard let obj = ACData.ATTENDANCEDETAILDATA else { return }
        classLabel.text = obj.school_class
        dateLabel.text = obj.session_date
        topicLabel.text = obj.subject_name
        subjectLabel.text = obj.chapter_name
    }
    @objc func approveAction() {
        let approvalVC = TeacherApprovalViewController()
        self.navigationController?.pushViewController(approvalVC, animated: true)
    }
    @objc func submitAction() {
        guard let obj = ACData.ATTENDANCEDETAILDATA else { return }
        let attendanceStatus = childAttendStatus ? 0 : 1
        ACRequest.POST_TEACHER_UPDATE_STUDENT_ATTENDANCE(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolSessionId: obj.school_session_id, childId: childIndex, isAttend: attendanceStatus, attendanceType: reasonSelected, note: noteText.text!, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            ACRequest.POST_DETAIL_ATTENDANCE(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, tokenAccess: ACData.LOGINDATA.accessToken, schoolSessionID: obj.school_session_id, successCompletion: { (detailData) in
                ACData.ATTENDANCEDETAILDATA = detailData
                SVProgressHUD.dismiss()
                self.studentView.isHidden = true
                self.collectionView.reloadData()
            }) { (message) in
                SVProgressHUD.dismiss()
            }
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    @objc func showReasonPicker() {
        ActionSheetStringPicker.show(
            withTitle: "Reason",
            rows: reasonArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                self.reasonSelected = indexes + 1
                self.reasonButton.setTitle(values as? String, for: .normal)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )

    }
    @objc func closeStudentView() {
        studentView.isHidden = true
    }
}

extension AttendanceDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ACData.ATTENDANCEDETAILDATA.attendanceStudent.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "attendanceUserCellID", for: indexPath) as? AttendanceUserCell)!
        cell.userName.text = "\(ACData.ATTENDANCEDETAILDATA.attendanceStudent[indexPath.row].childName)"
        cell.userImage.layer.cornerRadius = cell.userImage.frame.width / 2
        cell.userImage.sd_setImage(
            with: URL(string: (ACData.ATTENDANCEDETAILDATA.attendanceStudent[indexPath.row].childImage)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        guard let studentObj = ACData.ATTENDANCEDETAILDATA else { return }
        studentView.isHidden = false
        if studentObj.attendanceStudent[indexPath.row].isAttend {
            reasonButton.isUserInteractionEnabled = true
            reasonButton.backgroundColor = .groupTableViewBackground
            reasonIconImage.isHidden = false
            reasonButton.setTitle("Reason", for: .normal)
            reasonButton.setTitleColor(.black, for: .normal)
            submitButton.setTitle("Submit", for: .normal)
        } else {
            reasonButton.isUserInteractionEnabled = false
            reasonButton.backgroundColor = .clear
            reasonIconImage.isHidden = true
            reasonButton.setTitle("Absent", for: .normal)
            reasonButton.setTitleColor(.red, for: .normal)
            submitButton.setTitle("Cancel Absent", for: .normal)
        }
        studentImage.sd_setImage(
            with: URL(string: (studentObj.attendanceStudent[indexPath.row].childImage)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        studentName.text = studentObj.attendanceStudent[indexPath.row].childName
        childIndex = studentObj.attendanceStudent[indexPath.row].childID
        childAttendStatus = studentObj.attendanceStudent[indexPath.row].isAttend
    }
}

extension AttendanceDetailViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            notes = textView.text!
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Note"
            textView.textColor = UIColor.lightGray
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        notes = textView.text!
    }
}
