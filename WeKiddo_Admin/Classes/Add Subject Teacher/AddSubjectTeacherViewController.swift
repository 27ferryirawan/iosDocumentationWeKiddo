//
//  AddSubjectTeacherViewController.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 14/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation
import SVProgressHUD
import SDWebImage

class AddSubjectTeacherViewController: UIViewController {

    var sessionCount = 1
    var classCount = 1
    var attachmentCount = 0
    var voiceNoteCount = 0
    var attachmentArray = [SubjectTeacherDetailMediasModel]()
    var voiceNoteArray = [SubjectTeacherDetailMediasModel]()
    var selectedSessionArray = [SubjectTeacherSessionSelectedModel]()
    var selectedClassArray = [SubjectTeacherParamClassSelectedModel]()
    var isUploadViewDisplayed = false
    var fileURL = ""
    var mediaType = ""
    var mediaFile = ""
    var chapterTitle = ""
    var chapterID: String?
    var chapterDesc = ""
    var isExam = false
    var examTitle = ""
    var examDesc = ""
    var addMoreClicked = false
    var fileData = Data()
    var attachmentReason = ""
    var isUploadImage = Bool()
    var audioRecorder: AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    var meterTimer:Timer!
    var isAudioRecordingGranted: Bool!
    var isRecording = false
    var isPlaying = false
    var isFromEdit = Bool()
//    var jsonEncoder = JSONEncoder()
    @IBOutlet weak var addFileLabel: UILabel!
    @IBOutlet weak var attachmentTitleLabel: UILabel!
    @IBOutlet var recordingTimeLabel: UILabel!
    @IBOutlet var play_btn_ref: UIButton!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var attachmentImage: UIImageView!

    @IBOutlet weak var attachmentTextfield: UITextField!
    @IBOutlet weak var closeAttachmentButton: UIButton!
    @IBOutlet weak var uploadAttachmentView: UIView! {
        didSet {
            uploadAttachmentView.setBorderShadow(color: UIColor.gray, shadowRadius: 2.0, shadowOpactiy: 1, shadowOffsetWidth: 2, shadowOffsetHeight: 2)
        }
    }
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color: UIColor.gray, shadowRadius: 3.0, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var subject_chapter_detail_session_week = [SubjectTeacherDetailSessionWeekModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constructData()
        configNavigation()
        configTable()
        updateView()
        check_record_permission()
    }
    
    func constructData() {
        selectedClassArray.append(SubjectTeacherParamClassSelectedModel(schoolClassName: "Select Class", schoolClassID: ""))
        if isFromEdit {
            chapterTitle = ACData.SUBJECTTEACHERDETAILMODEL.chapter_name
            chapterID = ACData.SUBJECTTEACHERDETAILMODEL.chapter_id
            chapterDesc = ACData.SUBJECTTEACHERDETAILMODEL.chapter_desc
            configureSessionWeek()
            titleLabel.text = "Level \(ACData.SUBJECTTEACHERDETAILMODEL.school_level)"
            sessionCount = subject_chapter_detail_session_week.count
            classCount = ACData.SUBJECTTEACHERDETAILMODEL.subject_chapter_classes.count
            for mediaObj in ACData.SUBJECTTEACHERDETAILMODEL.subject_chapter_medias {
                if mediaObj.media_type_id == "MT6" {
                    voiceNoteArray.append(mediaObj)
                } else {
                    attachmentArray.append(mediaObj)
                }
            }
            voiceNoteCount = voiceNoteArray.count
            attachmentCount = attachmentArray.count
            tableView.reloadData()
        } else {
            sessionCount = 1
            classCount = 1
            voiceNoteCount = 0
            attachmentCount = 0
        }
        /* // Only use it when the data collection are heavy
            if let encoded = try? jsonEncoder.encode(selectedClassArray) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "classSelected")
         }
        */
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Subject Teacher List", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "AddSubjectTeacherHeaderCell", bundle: nil), forCellReuseIdentifier: "addSubjectTeacherHeaderCellID")
        tableView.register(UINib(nibName: "AddSubjectTeacherSessionCell", bundle: nil), forCellReuseIdentifier: "addSubjectTeacherSessionCellID")
        tableView.register(UINib(nibName: "AddSubjectTeacherAddMoreSessionCell", bundle: nil), forCellReuseIdentifier: "addSubjectTeacherAddMoreSessionCellID")
        tableView.register(UINib(nibName: "AddSubjectTeacherSectionCell", bundle: nil), forCellReuseIdentifier: "addSubjectTeacherSectionCellID")
        tableView.register(UINib(nibName: "AddSubjectTeacherClassSelectedCell", bundle: nil), forCellReuseIdentifier: "addSubjectTeacherClassSelectedCellID")
        tableView.register(UINib(nibName: "AddSubjectTeacherAttachmentVoiceButtonCell", bundle: nil), forCellReuseIdentifier: "addSubjectTeacherAttachmentVoiceButtonCellID")
        tableView.register(UINib(nibName: "AddSubjectTeacherAttachmentCell", bundle: nil), forCellReuseIdentifier: "addSubjectTeacherAttachmentCellID")
        tableView.register(UINib(nibName: "AddSubjectTeacherFooterCell", bundle: nil), forCellReuseIdentifier: "addSubjectTeacherFooterCellID")
        tableView.register(UINib(nibName: "AddSubjectTeacherSectionAttachmentCell", bundle: nil), forCellReuseIdentifier: "addSubjectTeacherSectionAttachmentCellID")
        
        takePhotoButton.addTarget(self, action: #selector(addImageAction), for: .touchUpInside)
        uploadButton.addTarget(self, action: #selector(uploadAction), for: .touchUpInside)
        closeAttachmentButton.addTarget(self, action: #selector(closeAttachmentPreview), for: .touchUpInside)

    }
    func updateView() {
        if isUploadViewDisplayed {
            if isUploadImage {
                self.attachmentImage.isHidden = false
                self.takePhotoButton.isHidden = false
                self.addFileLabel.isHidden = false
                self.play_btn_ref.isHidden = true
                self.recordingTimeLabel.isHidden = true
            } else {
                self.attachmentImage.isHidden = true
                self.takePhotoButton.isHidden = true
                self.addFileLabel.isHidden = true
                self.play_btn_ref.isHidden = false
                self.recordingTimeLabel.isHidden = false
            }
            uploadAttachmentView.isHidden = false
            isUploadViewDisplayed = false
        } else {
            uploadAttachmentView.isHidden = true
            isUploadViewDisplayed = true
        }
    }
}

extension AddSubjectTeacherViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8 + sessionCount + classCount + attachmentCount + voiceNoteCount
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 207 // header
        } else if indexPath.row <= sessionCount {
            return 129 // session picker and collection
        } else if indexPath.row == 1 + sessionCount {
            return 44 // button add more
        } else if indexPath.row == 2 + sessionCount {
            return 73 // section class and picker
        } else if indexPath.row > 2 + sessionCount && indexPath.row < 3 + sessionCount + classCount {
            return 25 // selected class
        } else if indexPath.row == 3 + sessionCount + classCount {
            return 44 // button add more
        } else if indexPath.row == 4 + sessionCount + classCount {
            return 44 // attachment button
        } else if indexPath.row == 5 + sessionCount + classCount {
            return 25 // attachment section
        } else if indexPath.row > 5 + sessionCount + classCount && indexPath.row < 6 + sessionCount + classCount + attachmentCount {
            return 44
        } else if indexPath.row == 6 + sessionCount + classCount + attachmentCount {
            return 25
        } else if indexPath.row > 6 + sessionCount + classCount + attachmentCount && indexPath.row < 7 + sessionCount + classCount + attachmentCount + voiceNoteCount {
            return 44
        } else {
            return 256
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addSubjectTeacherHeaderCellID", for: indexPath) as? AddSubjectTeacherHeaderCell)!
            cell.delegate = self
            if isFromEdit {
                cell.detailObj = ACData.SUBJECTTEACHERDETAILMODEL
                cell.cellConfig()
            }
            return cell
        } else if indexPath.row <= sessionCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addSubjectTeacherSessionCellID", for: indexPath) as? AddSubjectTeacherSessionCell)!
            cell.delegate = self
            cell.currentSession = sessionCount
            cell.currentSection = indexPath.row-1
            cell.currentIndexPath = indexPath.row
            cell.isFromEdit = isFromEdit
            
            if isFromEdit {
                if indexPath.row-1 < subject_chapter_detail_session_week.count {
                    cell.detailEditObj = subject_chapter_detail_session_week[indexPath.row-1]
                } else {
                    cell.currentIndexPath = -1
                    cell.detailObj = ACData.SUBJECTTEACHERPARAMMODEL
                }
            } else {
                cell.detailObj = ACData.SUBJECTTEACHERPARAMMODEL
            }
            return cell
        } else if indexPath.row == 1 + sessionCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addSubjectTeacherAddMoreSessionCellID", for: indexPath) as? AddSubjectTeacherAddMoreSessionCell)!
            cell.isAddSession = true
            cell.delegate = self
            return cell
        } else if indexPath.row == 2 + sessionCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addSubjectTeacherSectionCellID", for: indexPath) as? AddSubjectTeacherSectionCell)!
            if isFromEdit {
                if let data = ACData.SUBJECTTEACHERDETAILMODEL?.subject_chapter_classes.first {
                    cell.classPickerButton.setTitle(data.school_class, for: .normal)
                    classSelected(withClassName: data.school_class, withClassID: data.school_class_id, withCurrentID: 0, withIndexpathat: 0)
                }
            }
            cell.detailObj = ACData.SUBJECTTEACHERPARAMMODEL
            cell.indexPathat = indexPath.row + classCount
            cell.currentIndex = /*indexPath.row - (2 + sessionCount)*/self.selectedClassArray.count - 1
            cell.delegate = self
            return cell
        } else if indexPath.row > 2 + sessionCount && indexPath.row < 3 + sessionCount + classCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addSubjectTeacherClassSelectedCellID", for: indexPath) as? AddSubjectTeacherClassSelectedCell)!
            cell.selectedClassArray = self.selectedClassArray
            cell.cellConfig(atIndex: indexPath.row - (3+sessionCount))
            /* // Only use it when the data collection are heavy
            let placeData = UserDefaults.standard.data(forKey: "classSelected")
            let placeArray = try! JSONDecoder().decode([SubjectTeacherParamClassSelectedModel].self, from: placeData!)
            selectedClassArray = placeArray
             */
            return cell
        } else if indexPath.row == 3 + sessionCount + classCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addSubjectTeacherAddMoreSessionCellID", for: indexPath) as? AddSubjectTeacherAddMoreSessionCell)!
            cell.isAddSession = false
            cell.delegate = self
            return cell
        } else if indexPath.row == 4 + sessionCount + classCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addSubjectTeacherAttachmentVoiceButtonCellID", for: indexPath) as? AddSubjectTeacherAttachmentVoiceButtonCell)!
            cell.delegate = self
            return cell
        } else if indexPath.row == 5 + sessionCount + classCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addSubjectTeacherSectionAttachmentCellID", for: indexPath) as? AddSubjectTeacherSectionAttachmentCell)!
            cell.cellConfig(isAttachment: true)
            return cell
        } else if indexPath.row > 5 + sessionCount + classCount && indexPath.row < 6 + sessionCount + classCount + attachmentCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addSubjectTeacherAttachmentCellID", for: indexPath) as? AddSubjectTeacherAttachmentCell)!
            if ACData.SUBJECTTEACHERDATATACHMENTDATAMODEL.count != 0 {
                cell.detailAttcObj = ACData.SUBJECTTEACHERDATATACHMENTDATAMODEL[indexPath.row - (6+sessionCount+classCount)]
            }
            return cell
        } else if indexPath.row == 6 + sessionCount + classCount + attachmentCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addSubjectTeacherSectionAttachmentCellID", for: indexPath) as? AddSubjectTeacherSectionAttachmentCell)!
            cell.cellConfig(isAttachment: false)
            return cell
        } else if indexPath.row > 6 + sessionCount + classCount + attachmentCount && indexPath.row < 7 + sessionCount + classCount + attachmentCount + voiceNoteCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addSubjectTeacherAttachmentCellID", for: indexPath) as? AddSubjectTeacherAttachmentCell)!
            if ACData.SUBJECTTEACHERDATAVOICENOTEMODEL.count != 0 {
                cell.detailVNObj = ACData.SUBJECTTEACHERDATAVOICENOTEMODEL[indexPath.row - (7+sessionCount+classCount+attachmentCount)]
            }
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addSubjectTeacherFooterCellID", for: indexPath) as? AddSubjectTeacherFooterCell)!
            cell.isExam = isExam
            cell.examButton.setTitle(examTitle, for: .normal)
            cell.examDescription.text = examDesc
            cell.delegate = self
            return cell
        }
    }
}

extension AddSubjectTeacherViewController: AddSubjectTeacherAddMoreSessionCellDelegate, AddSubjectTeacherSectionCellDelegate, AddSubjectTeacherAttachmentVoiceButtonCellDelegate, AddSubjectTeacherFooterCellDelegate, AddSubjectTeacherHeaderCellDelegate, AddSubjectTeacherSessionCellDelegate {
    func sessionWeekAdded(data: SubjectTeacherDetailSessionWeekModel) {
        subject_chapter_detail_session_week.append(data)
        tableView.reloadData()
    }
    
    func sessionArrayCollected(withArray: [SubjectTeacherSessionSelectedModel]) {
        selectedSessionArray.append(contentsOf: withArray)
        selectedSessionArray = selectedSessionArray.unique{ $0.valueAt }
        
        for selectedSession in selectedSessionArray {
            print("\(selectedSession.valueAt)")
        }
    }
    
    func sessionArrayCollectedFirst(withArray: [SubjectTeacherSessionSelectedModel]) {
//        selectedSessionArray = withArray
    }
    
    func titleFilled(withValue: String) {
        chapterTitle = withValue
    }
    
    func descFilled(withValue: String) {
        chapterDesc = withValue
    }
    func saveSubjectTopicAction() {
        
//        print("Session: \(ACData.SUBJECTTEACHERPARAMMODEL.week_session.count)")
        
        var addAttachmentOn = "["
        var addVoiceNoteOn = "["
        var addSessionOn = "["
        var addClassOn = "["
        
        if ACData.SUBJECTTEACHERDATATACHMENTDATAMODEL.count != 0 {
            var i = 0
            for data in ACData.SUBJECTTEACHERDATATACHMENTDATAMODEL {
                if i > 0 {
                    addAttachmentOn += ","
                }
                addAttachmentOn += "{"
                addAttachmentOn += "\"id\":\"\(data.media_id)\""
                addAttachmentOn += "}"

                i += 1
            }
        }
        if ACData.SUBJECTTEACHERDATAVOICENOTEMODEL.count != 0 {
            var i = 0
            for data in ACData.SUBJECTTEACHERDATATACHMENTDATAMODEL {
                if i > 0 {
                    addVoiceNoteOn += ","
                }
                addVoiceNoteOn += "{"
                addVoiceNoteOn += "\"id\":\"\(data.media_id)\""
                addVoiceNoteOn += "}"

                i += 1
            }
        }
        if selectedSessionArray.count != 0 {
            var i = 0
            for data in selectedSessionArray {
                if i > 0 {
                    addSessionOn += ","
                }
                addSessionOn += "{"
                addSessionOn += "\"session_count\":\"\(data.valueAt)\""
                addSessionOn += "}"
                
                i += 1
            }
        }
        if selectedClassArray.count != 0 {
            var i = 0
            for data in selectedClassArray {
                if data.school_class_id == "Select Class" || data.school_class_id == "" {
                    ACAlert.show(message: "Please Select Class")
                    return
                }
                
                if i > 0 {
                    addClassOn += ","
                }
                addClassOn += "{"
                addClassOn += "\"school_class_id\":\"\(data.school_class_id)\""
                addClassOn += "}"
                
                i += 1
            }
        }
        
        addAttachmentOn += "]"
        addVoiceNoteOn += "]"
        addSessionOn += "]"
        addClassOn += "]"

        let newAddAttachmentOn = addAttachmentOn.replacingOccurrences(of: "\\", with: "")
        let jsonAttachmentData = newAddAttachmentOn.data(using: .utf8)!
        let jsonAttachment = try! JSONSerialization.jsonObject(with: jsonAttachmentData, options: .allowFragments)

        let newAddVoiceNoteOn = addVoiceNoteOn.replacingOccurrences(of: "\\", with: "")
        let jsonVoiceNoteData = newAddVoiceNoteOn.data(using: .utf8)!
        let jsonVoiceNote = try! JSONSerialization.jsonObject(with: jsonVoiceNoteData, options: .allowFragments)

        let newAddSessionOn = addSessionOn.replacingOccurrences(of: "\\", with: "")
        let jsonSessionData = newAddSessionOn.data(using: .utf8)!
        let jsonSession = try! JSONSerialization.jsonObject(with: jsonSessionData, options: .allowFragments)

        let newAddClassOn = addClassOn.replacingOccurrences(of: "\\", with: "")
        let jsonClassData = newAddClassOn.data(using: .utf8)!
        let jsonClass = try! JSONSerialization.jsonObject(with: jsonClassData, options: .allowFragments)

        print("schoolId: \(ACData.LOGINDATA.school_id), userId: \(ACData.LOGINDATA.userID), role: \(ACData.LOGINDATA.role), yearId: \(ACData.LOGINDATA.year_id), schoolGradId: \(ACData.SUBJECTTEACHERCHAPTERLISTDATA.school_grade_id), schoolLevelId: \(ACData.SUBJECTTEACHERCHAPTERLISTDATA.school_level_id), subjecId: \(ACData.SUBJECTTEACHERCHAPTERLISTDATA.subject_id), schoolMajorId: \(ACData.SUBJECTTEACHERCHAPTERLISTDATA.school_major_id), chapterName: \(chapterTitle), chapterDesc: \(chapterDesc), attachmentList: \(jsonAttachment), voiceNoteList: \(jsonVoiceNote), sessionList: \(jsonSession), classList: \(jsonClass), isExam: \(isExam), examType: \(examTitle), examDesc: \(examDesc)")
        
        let parameters: Parameters = [
            "school_id":ACData.LOGINDATA.school_id,
            "year_id":ACData.LOGINDATA.year_id,
            "school_grade_id":ACData.SUBJECTTEACHERCHAPTERLISTDATA.school_grade_id,
            "school_level_id":ACData.SUBJECTTEACHERCHAPTERLISTDATA.school_level_id,
            "user_id":ACData.LOGINDATA.userID,
            "role":ACData.LOGINDATA.role,
            "subject_id":ACData.SUBJECTTEACHERCHAPTERLISTDATA.subject_id,
            "school_major_id":ACData.SUBJECTTEACHERCHAPTERLISTDATA.school_major_id,
            "chapter_name":chapterTitle,
            "chapter_desc":chapterDesc,
            "attachment_list":jsonAttachment,
            "voicenote_list":jsonVoiceNote,
            "classes":jsonClass,
            "sessioncounts":jsonSession,
            "is_exam":isExam,
            "exam_type":examTitle,
            "chapter_id":chapterID ?? "",
            "exam_description":examDesc
        ]

        ACRequest.POST_ADD_NEW_SUBJECT_TEACHER_CHAPTER(params: parameters, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: status)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func isExamValue(withValue: Bool) {
        isExam = withValue
    }
    func isExamTypeFilled(withValue: String) {
        examTitle = withValue
    }
    func isExamDescFilled(withValue: String) {
       examDesc = withValue
    }

    func addMoreSession() {
        addMoreClicked = true
        ACRequest.POST_GET_PARAM_FOR_ADD_SUBJECT_TEACHER(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, schoolLevelID: ACData.SUBJECTTEACHERCHAPTERLISTDATA.school_level_id, subjectID: ACData.SUBJECTTEACHERCHAPTERLISTDATA.subject_id, schoolGradeID: ACData.SUBJECTTEACHERCHAPTERLISTDATA.school_grade_id, schoolMajorID: ACData.SUBJECTTEACHERCHAPTERLISTDATA.school_major_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
            SVProgressHUD.dismiss()
            ACData.SUBJECTTEACHERPARAMMODEL = jsonDatas
            self.sessionCount += 1
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func classSelected(withClassName: String, withClassID: String, withCurrentID: Int, withIndexpathat: Int) {
        selectedClassArray[withCurrentID].school_class_id = withClassID
        selectedClassArray[withCurrentID].school_class_name = withClassName
        /* // Only use it when the data collection are heavy
        if let encoded = try? jsonEncoder.encode(selectedClassArray) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "classSelected")
        }
        */
        tableView.reloadRows(at: [IndexPath(row: withIndexpathat, section: 0)], with: .none)
    }
    func addMoreClass() {
        classCount += 1
        selectedClassArray.append(SubjectTeacherParamClassSelectedModel(schoolClassName: "Select Class", schoolClassID: ""))
        for item in selectedClassArray {
            print("item: \(item.school_class_name)")
        }
        /* // Only use it when the data collection are heavy
         if let encoded = try? jsonEncoder.encode(selectedClassArray) {
         let defaults = UserDefaults.standard
         defaults.set(encoded, forKey: "classSelected")
         }
         */
        tableView.reloadData()
    }
    func showAttachmentView(isAttachment: Bool) {
        if isAttachment {
            self.isUploadImage = true
        } else {
            self.isUploadImage = false
        }
        isUploadViewDisplayed = true
        updateView()
    }
}

extension AddSubjectTeacherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        attachmentReason = textField.text!
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        attachmentReason = textField.text!
        return true
    }
}

extension AddSubjectTeacherViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            let newImage = selectedImage.resizeImage(30.0, opaque: false)
            let imageData = newImage.pngData()!
            picker.dismiss(animated: true) {
                DispatchQueue.main.async {
                    self.attachmentImage.image = UIImage(named: "ic_attach")
                }
                self.fileData = imageData
            }
        } else {
            guard let fileUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL else {
                return
            }
            do {
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                print(data)
                picker.dismiss(animated: true) {
                    DispatchQueue.main.async {
                        self.attachmentImage.image = UIImage(named: "ic_attach")
                    }
                    self.fileData = data
                }
            } catch  {
                
            }
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension AddSubjectTeacherViewController: AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    @objc func updateAudioMeter(timer: Timer)
    {
        if audioRecorder.isRecording
        {
            let hr = Int((audioRecorder.currentTime / 60) / 60)
            let min = Int(audioRecorder.currentTime / 60)
            let sec = Int(audioRecorder.currentTime.truncatingRemainder(dividingBy: 60))
            let totalTimeString = String(format: "%02d:%02d:%02d", hr, min, sec)
            recordingTimeLabel.text = totalTimeString
            audioRecorder.updateMeters()
        }
    }
    
    func finishAudioRecording(success: Bool)
    {
        if success
        {
            audioRecorder.stop()
            audioRecorder = nil
            meterTimer.invalidate()
            print("recorded successfully.")
        }
        else
        {
            ACAlert.show(message: "Recording Failed.")
        }
    }
    func check_record_permission() {
        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSessionRecordPermission.granted:
            isAudioRecordingGranted = true
            break
        case AVAudioSessionRecordPermission.denied:
            isAudioRecordingGranted = false
            break
        case AVAudioSessionRecordPermission.undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission({ (allowed) in
                if allowed {
                    self.isAudioRecordingGranted = true
                } else {
                    self.isAudioRecordingGranted = false
                }
            })
            break
        default:
            break
        }
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    func getFileUrl() -> URL {
        let filename = "myRecording.m4a"
        let filePath = getDocumentsDirectory().appendingPathComponent(filename)
        return filePath
    }
    func setup_recorder()
    {
        if isAudioRecordingGranted
        {
            let session = AVAudioSession.sharedInstance()
            do
            {
                try session.setCategory(AVAudioSession.Category.playAndRecord, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
                try session.setActive(true)
                let settings = [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 44100,
                    AVNumberOfChannelsKey: 2,
                    AVEncoderAudioQualityKey:AVAudioQuality.high.rawValue
                ]
                audioRecorder = try AVAudioRecorder(url: getFileUrl(), settings: settings)
                audioRecorder.delegate = self
                audioRecorder.isMeteringEnabled = true
                audioRecorder.prepareToRecord()
            }
            catch let error {
                ACAlert.show(message: error.localizedDescription)
            }
        }
        else
        {
            ACAlert.show(message: "Don't have access to use your microphone.")
        }
    }
    func prepare_play()
    {
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: getFileUrl())
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
        }
        catch{
            print("Error")
        }
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool)
    {
        if !flag
        {
            finishAudioRecording(success: false)
        }
        play_btn_ref.isEnabled = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
    {
        
    }
    
    func configureSessionWeek() {
        subject_chapter_detail_session_week = ACData.SUBJECTTEACHERDETAILMODEL.subject_chapter_detail_session_week
        
        ACRequest.POST_GET_PARAM_FOR_ADD_SUBJECT_TEACHER(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, schoolLevelID: ACData.SUBJECTTEACHERCHAPTERLISTDATA.school_level_id, subjectID: ACData.SUBJECTTEACHERCHAPTERLISTDATA.subject_id, schoolGradeID: ACData.SUBJECTTEACHERCHAPTERLISTDATA.school_grade_id, schoolMajorID: ACData.SUBJECTTEACHERCHAPTERLISTDATA.school_major_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
            SVProgressHUD.dismiss()
            ACData.SUBJECTTEACHERPARAMMODEL = jsonDatas
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
}

extension AddSubjectTeacherViewController {
    //MARK: Action
    func uploadAttachment(withURL: Data) {
        
    }
    @objc func uploadAction() {
        if isUploadImage {
            let parameter: Parameters = [
                "user_id": ACData.LOGINDATA.userID,
                "role": ACData.LOGINDATA.role,
                "school_id": ACData.LOGINDATA.school_id,
                "year_id":ACData.LOGINDATA.year_id,
                "media_type":"MT4",
                "attach_title":attachmentTextfield.text!
            ]
            ACRequest.POST_ADD_NEW_ATTACHMENT_FILE_SUBJECT_TEACHER(parameters: parameter, file: fileData, fileName: "media_file", fileParameter: "media_file", tokenAccess: ACData.LOGINDATA.accessToken, mimeType: "", successCompletion: { (status) in
                SVProgressHUD.dismiss()
                ACData.SUBJECTTEACHERDATATACHMENTDATAMODEL = status
                self.attachmentCount = ACData.SUBJECTTEACHERDATATACHMENTDATAMODEL.count
                self.isUploadViewDisplayed = false
                self.updateView()
                self.tableView.reloadData()
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        } else {
            let parameter: Parameters = [
                "user_id": ACData.LOGINDATA.userID,
                "role": ACData.LOGINDATA.role,
                "school_id": ACData.LOGINDATA.school_id,
                "year_id":ACData.LOGINDATA.year_id,
                "media_type":"MT6",
                "attach_title":attachmentTextfield.text!
            ]
            do {
                if FileManager.default.fileExists(atPath: getFileUrl().path) {
                    ACRequest.POST_ADD_NEW_ATTACHMENT_FILE_VOICE_SUBJECT_TEACHER(parameters: parameter, file: getFileUrl(), fileName: "media_file", fileParameter: "media_file", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
                        SVProgressHUD.dismiss()
                        ACData.SUBJECTTEACHERDATAVOICENOTEMODEL = status
                        self.voiceNoteCount = ACData.SUBJECTTEACHERDATAVOICENOTEMODEL.count
                        self.isUploadViewDisplayed = false
                        self.updateView()
                        self.tableView.reloadData()
                    }) { (message) in
                        SVProgressHUD.dismiss()
                        ACAlert.show(message: message)
                    }
                } else {
                    ACAlert.show(message: "Audio file is missing.")
                }
            } catch {
                print("Unable to load data: \(error)")
            }
        }
    }
    @objc func closeAttachmentPreview() {
        isUploadViewDisplayed = false
        updateView()
    }
    @objc func addImageAction() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionsheet = UIAlertController(title: "Browse Attachment", message: "Choose A Source", preferredStyle: .alert)
        actionsheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction)in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("Camera is Not Available")
            }
        }))
        actionsheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction)in
            imagePickerController.sourceType = .savedPhotosAlbum
            imagePickerController.mediaTypes = ["public.image", "public.movie"]
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionsheet,animated: true, completion: nil)
    }
    @IBAction func startRecording(_ sender: UIButton) {
        if(isRecording) {
            finishAudioRecording(success: true)
            play_btn_ref.isEnabled = true
            play_btn_ref.setImage(UIImage(named: "play-button"), for: .normal)
            isRecording = false
        } else {
            setup_recorder()
            
            audioRecorder.record()
            meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(self.updateAudioMeter(timer:)), userInfo:nil, repeats:true)
            play_btn_ref.isEnabled = true
            play_btn_ref.setImage(UIImage(named: "stop"), for: .normal)
            isRecording = true
        }
    }
}

extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        
        return arrayOrdered
    }
}
