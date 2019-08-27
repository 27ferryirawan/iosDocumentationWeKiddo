//
//  TeacherOnDutyViewController.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 12/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import SVProgressHUD
import Alamofire

class TeacherOnDutyViewController: UIViewController {
    
    @IBOutlet weak var inReasonBtn: ButtonLeftSpace!
    @IBOutlet weak var closeInPopUpBtn: UIButton!
    @IBOutlet weak var detentionDescriptionTextView: UITextView!{
        didSet{
            detentionDescriptionTextView.layer.borderWidth = 1
            detentionDescriptionTextView.layer.borderColor = UIColor(hex: "#CCCCCC").cgColor
        }
    }
    @IBOutlet weak var detentionView: UIView!{
        didSet{
            detentionView.layer.borderWidth = 1
            detentionView.layer.borderColor = UIColor(hex: "#CCCCCC").cgColor
        }
    }
    @IBOutlet weak var inMinuteView: UILabel!{
        didSet{
            inMinuteView.layer.borderWidth = 1
            inMinuteView.layer.borderColor = UIColor(hex: "#CCCCCC").cgColor
        }
    }
    @IBOutlet weak var inHourView: UILabel!{
        didSet{
            inHourView.layer.borderWidth = 1
            inHourView.layer.borderColor = UIColor(hex: "#CCCCCC").cgColor
        }
    }
    @IBOutlet weak var goHomeEarlierView: UIView!{
        didSet{
            goHomeEarlierView.layer.cornerRadius = goHomeEarlierView.frame.size.width/2
            goHomeEarlierView.backgroundColor = ACColor.MAIN
        }
    }
    @IBOutlet weak var lateView: UIView!{
        didSet{
            lateView.layer.cornerRadius = lateView.frame.size.width/2
            lateView.backgroundColor = ACColor.MAIN
        }
    }
    @IBOutlet weak var descriptionTextView: UITextView!{
        didSet{
            descriptionTextView.layer.borderWidth = 1
            descriptionTextView.layer.borderColor = UIColor(hex: "#CCCCCC").cgColor
        }
    }
    @IBOutlet weak var inBorderView: UIView!{
        didSet{
            inBorderView.layer.borderWidth = 1
            inBorderView.layer.borderColor = UIColor(hex: "#CCCCCC").cgColor
        }
    }
    @IBOutlet weak var permissionView: UILabel!{
        didSet{
            permissionView.backgroundColor = ACColor.MAIN
        }
    }
    @IBOutlet weak var grayAreaBtn: UIButton!{
        didSet{
            grayAreaBtn.isHidden = true
            grayAreaBtn.backgroundColor = UIColor(displayP3Red: 102/255, green: 102/255, blue: 102/255, alpha: 0.8)
        }
    }
    @IBOutlet weak var inPopUpView: UIView!{
        didSet{
            inPopUpView.isHidden = true
        }
    }
    @IBOutlet weak var outBorderView: UIView!{
        didSet{
            outBorderView.layer.borderWidth = 1
            outBorderView.layer.borderColor = UIColor(hex: "#CCCCCC").cgColor
        }
    }
    @IBOutlet weak var outPopUpView: UIView!{
        didSet{
            outPopUpView.isHidden = true
        }
    }
    @IBOutlet weak var outPermissionLbl: UILabel!{
        didSet{
            outPermissionLbl.backgroundColor = ACColor.MAIN
        }
    }
    @IBOutlet weak var inChildImage: UIImageView!
    @IBOutlet weak var inChildNameLbl: UILabel!
    @IBOutlet weak var inLateLbl: UILabel!
    @IBOutlet weak var inGoHomeEarlierLbl: UILabel!
    @IBOutlet weak var outDescriptionTextView: UITextView!{
        didSet{
            outDescriptionTextView.layer.borderWidth = 1
            outDescriptionTextView.layer.borderColor = UIColor(hex: "#CCCCCC").cgColor
        }
    }
    @IBOutlet weak var outLateView: UIView!{
        didSet{
            outLateView.layer.cornerRadius = lateView.frame.size.width/2
            outLateView.backgroundColor = ACColor.MAIN
        }
    }
    @IBOutlet weak var outGoHomeEarlierView: UIView!{
        didSet{
            outGoHomeEarlierView.layer.cornerRadius = lateView.frame.size.width/2
            outGoHomeEarlierView.backgroundColor = ACColor.MAIN
        }
    }
    @IBOutlet weak var outChildImage: UIImageView!
    @IBOutlet weak var outGoHomeLbl: UILabel!
    @IBOutlet weak var outLateLbl: UILabel!
    @IBOutlet weak var outChildNameLbl: UILabel!
    @IBOutlet weak var outHourLbl: UILabel!{
        didSet{
            outHourLbl.layer.borderWidth = 1
            outHourLbl.layer.borderColor = UIColor(hex: "#CCCCCC").cgColor
        }
    }
    @IBOutlet weak var outMinuteLbl: UILabel!{
        didSet{
            outMinuteLbl.layer.borderWidth = 1
            outMinuteLbl.layer.borderColor = UIColor(hex: "#CCCCCC").cgColor
        }
    }

    @IBOutlet weak var inSaveBtn: UIButton!
    @IBOutlet weak var outReasonBtn: ButtonLeftSpace!
    @IBOutlet weak var leftRadioButtonImage: UIImageView!
    @IBOutlet weak var rightRadioButtonImage: UIImageView!
    @IBOutlet weak var leftRadioButton: UIButton!
    @IBOutlet weak var rightRadioButton: UIButton!
    @IBOutlet weak var inTimePickerButton: UIButton!
    @IBOutlet weak var outSaveBtn: UIButton!
    @IBOutlet weak var outTimePickerBtn: UIButton!
    @IBOutlet weak var outCloseBtn: UIButton!
    var isYesSelected = true
    var child_id = ""
    var reason = ""
//    var desc = ""
    @objc func showInTimePicker() {
        ActionSheetDatePicker.show(
            withTitle: "- Select Time -",
            datePickerMode: .time,
            selectedDate: Date(),
            doneBlock: { picker, selectedDate, origin in
                let dateFormatter = DateFormatter()
                let locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.dateFormat = "H:mm"
                dateFormatter.locale = locale
                let selectedDate = dateFormatter.string(from: selectedDate as! Date)
                var currentDate = selectedDate.components(separatedBy: ":")
                var minuteDate = currentDate[1].components(separatedBy: " ")
                self.inHourView.text = currentDate[0]
                self.inMinuteView.text = minuteDate[0]
        }, cancel: nil, origin: self.view)
    }
    @objc func showOutTimePicker() {
        ActionSheetDatePicker.show(
            withTitle: "- Select Time -",
            datePickerMode: .time,
            selectedDate: Date(),
            doneBlock: { picker, selectedDate, origin in
                let dateFormatter = DateFormatter()
                let locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.dateFormat = "H:mm"
                dateFormatter.locale = locale
                let selectedDate = dateFormatter.string(from: selectedDate as! Date)
                var currentDate = selectedDate.components(separatedBy: ":")
                var minuteDate = currentDate[1].components(separatedBy: " ")
                self.outHourLbl.text = currentDate[0]
                self.outMinuteLbl.text = minuteDate[0]
        }, cancel: nil, origin: self.view)
    }
    @objc func selectLeftRadioButton(){
        isYesSelected = true
        rightRadioButtonImage.image = UIImage(named: "circumference")
        leftRadioButtonImage.image = UIImage(named: "radio-on-button")
    }
    @objc func selectRightRadioButton(){
        isYesSelected = false
        rightRadioButtonImage.image = UIImage(named: "radio-on-button")
        leftRadioButtonImage.image = UIImage(named: "circumference")
    }
    func radioButtonSelected(){
        rightRadioButton.addTarget(self, action: #selector(selectRightRadioButton), for: .touchUpInside)
        leftRadioButton.addTarget(self, action: #selector(selectLeftRadioButton), for: .touchUpInside)
    }
    
    var inReasonDesc = [String]()
    var inReasonID = ""
    var outReasonDesc = [String]()
    var outReasonID = ""
    @objc func showInReasonPicker() {
        guard let obj = ACData.TEACHERONDUTYPICKERDATA else { return }
        for item in obj.in_reason_picker {
            inReasonDesc.append(item.reason_desc)
        }
        ActionSheetStringPicker.show(
            withTitle: "Reason",
            rows: inReasonDesc,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.inReasonBtn.setTitle(value, for: .normal)
                self.inReasonID = ACData.TEACHERONDUTYPICKERDATA.in_reason_picker[indexes].reason_id
                self.reason = value
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
        inReasonDesc.removeAll()
    }
    @objc func showOutReasonPicker() {
        guard let obj = ACData.TEACHERONDUTYPICKERDATA else { return }
        for item in obj.out_reason_picker {
            outReasonDesc.append(item.reason_desc)
        }
        ActionSheetStringPicker.show(
            withTitle: "Reason",
            rows: outReasonDesc,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.outReasonBtn.setTitle(value, for: .normal)
                self.inReasonID = ACData.TEACHERONDUTYPICKERDATA.out_reason_picker[indexes].reason_id
                self.reason = value
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
        outReasonDesc.removeAll()
    }
    
    func isDisplayOutPopUp(image:String, name:String, leave:Int, late:Int){
        outPopUpView.isHidden = false
        grayAreaBtn.isHidden = false
        outTimePickerBtn.addTarget(self, action: #selector(showOutTimePicker), for: .touchUpInside)
        outChildImage.sd_setImage(
            with: URL(string: (image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        outChildNameLbl.text = name
        outLateLbl.text = "\(late)"
        outGoHomeLbl.text = "\(leave)"
        outSaveBtn.addTarget(self, action: #selector(saveOut), for: .touchUpInside)
    }
    @objc func closeOutPopUp(){
        outPopUpView.isHidden = true
        grayAreaBtn.isHidden = true
    }
    func isDisplayInPopUp(image:String, name:String, leave:Int, late:Int){
        inPopUpView.isHidden = false
        grayAreaBtn.isHidden = false
        inTimePickerButton.addTarget(self, action: #selector(showInTimePicker), for: .touchUpInside)
        radioButtonSelected()
        inChildImage.sd_setImage(
            with: URL(string: (image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        inChildNameLbl.text = name
        inLateLbl.text = "\(late)"
        inGoHomeEarlierLbl.text = "\(leave)"
        inSaveBtn.addTarget(self, action: #selector(saveIn), for: .touchUpInside)
    }
    @objc func closeInPopUp(){
        inPopUpView.isHidden = true
        grayAreaBtn.isHidden = true
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPickerData()
        configTable()
        configNavigation()
        inReasonBtn.addTarget(self, action: #selector(showInReasonPicker), for: .touchUpInside)
        outReasonBtn.addTarget(self, action: #selector(showOutReasonPicker), for: .touchUpInside)
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Teacher On Duty", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Teacher On Duty", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable(){
        tableView.register(UINib(nibName: "TeacherOnDutyCell", bundle: nil), forCellReuseIdentifier: "teacherOnDutyCellID")
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.estimatedRowHeight = 303;
    }
    func fetchPickerData(){
        ACRequest.POST_TEACHER_ON_DUTY_PICKER_LIST(schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (teacherOnDutyPickerData) in
            SVProgressHUD.dismiss()
            ACData.TEACHERONDUTYPICKERDATA = teacherOnDutyPickerData
            self.tableView.reloadData()
        }, failCompletion: { (message) in
            SVProgressHUD.dismiss()
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            }))
            self.present(alert, animated: true)
        })
    }
    @objc func saveIn(){
        let parameters: Parameters = [
            "child_id": child_id,
            "school_id": ACData.LOGINDATA.school_id,
            "year_id": ACData.LOGINDATA.year_id,
            "user_id": ACData.LOGINDATA.userID,
            "role": ACData.LOGINDATA.role,
            "reason": reason,
            "desc": descriptionTextView.text!,
            "detention_reason" : detentionDescriptionTextView.text!,
            "detention" : isYesSelected
        ]
        print(child_id)
        print(ACData.LOGINDATA.school_id)
        print(ACData.LOGINDATA.year_id)
        print(ACData.LOGINDATA.userID)
        print(ACData.LOGINDATA.role)
        print(descriptionTextView.text!)
        print(reason)
        print(parameters)
        ACRequest.POST_ADD_TEACHER_ON_DUTY_PERMISSION(params: parameters, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: {(status) in
            SVProgressHUD.dismiss()
            self.inPopUpView.isHidden = true
            self.grayAreaBtn.isHidden = true
            ACAlert.show(message: status)
        }){ (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    @objc func saveOut(){
        let parameters: Parameters = [
            "child_id": child_id,
            "school_id": ACData.LOGINDATA.school_id,
            "year_id": ACData.LOGINDATA.year_id,
            "user_id": ACData.LOGINDATA.userID,
            "role": ACData.LOGINDATA.role,
            "reason": reason,
            "desc": outDescriptionTextView.text!,
            "detention_reason" : "",
            "detention" : false
        ]
        print(child_id)
        print(ACData.LOGINDATA.school_id)
        print(ACData.LOGINDATA.year_id)
        print(ACData.LOGINDATA.userID)
        print(ACData.LOGINDATA.role)
        print(descriptionTextView.text!)
        print(reason)
        print(parameters)
        ACRequest.POST_ADD_TEACHER_ON_DUTY_PERMISSION(params: parameters, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: {(status) in
            SVProgressHUD.dismiss()
            self.inPopUpView.isHidden = true
            self.grayAreaBtn.isHidden = true
            ACAlert.show(message: status)
        }){ (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    
}
extension TeacherOnDutyViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 818
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "teacherOnDutyCellID", for: indexPath) as? TeacherOnDutyCell)!
        cell.object = ACData.TEACHERONDUTYPICKERDATA
        cell.schoolObj = ACData.TEACHERONDUTYGETLISTDATA
        cell.delegate = self
        return cell
    }
}
extension TeacherOnDutyViewController : TeacherOnDutyDelegate{
    func classPickerID(classID: String) {
        ACRequest.POST_TEACHER_ON_DUTY_CHILD_LIST(schoolClassID: classID, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (teacherOnDutyData) in
            SVProgressHUD.dismiss()
            ACData.TEACHERONDUTYGETLISTDATA = teacherOnDutyData
            self.tableView.reloadData()
        }, failCompletion: { (message) in
            SVProgressHUD.dismiss()
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            }))
            self.present(alert, animated: true)
        })
    }
    func popUp(indexPath: Int, child_image:String, child_name:String, early_leave:Int, late_info:Int, child_id:String) {
        // 1 no img
        // 2 silang
        // 3 seru
        // 4 centang
        self.child_id = child_id
        if ACData.TEACHERONDUTYGETLISTDATA.class_info[indexPath].status == 1{
            
        } else if ACData.TEACHERONDUTYGETLISTDATA.class_info[indexPath].status == 2{
            isDisplayInPopUp(image:child_image, name:child_name, leave:early_leave, late:late_info)
            grayAreaBtn.addTarget(self, action: #selector(closeInPopUp), for: .touchUpInside)
            closeInPopUpBtn.addTarget(self, action: #selector(closeInPopUp), for: .touchUpInside)
        } else if ACData.TEACHERONDUTYGETLISTDATA.class_info[indexPath].status == 3{
            isDisplayOutPopUp(image:child_image, name:child_name, leave:early_leave, late:late_info)
            grayAreaBtn.addTarget(self, action: #selector(closeOutPopUp), for: .touchUpInside)
            closeInPopUpBtn.addTarget(self, action: #selector(closeOutPopUp), for: .touchUpInside)
        } else if ACData.TEACHERONDUTYGETLISTDATA.class_info[indexPath].status == 4{
            isDisplayOutPopUp(image:child_image, name:child_name, leave:early_leave, late:late_info)
            grayAreaBtn.addTarget(self, action: #selector(closeOutPopUp), for: .touchUpInside)
            outCloseBtn.addTarget(self, action: #selector(closeOutPopUp), for: .touchUpInside)
        }
    }
    func showAlert(withMessage: String) {
        let alert = UIAlertController(title: nil, message: withMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

