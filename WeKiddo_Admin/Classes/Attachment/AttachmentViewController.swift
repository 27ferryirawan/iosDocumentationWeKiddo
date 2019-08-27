//
//  AttachmentViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 10/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
import ActionSheetPicker_3_0
import AVFoundation
import Alamofire
import SDWebImage

class AttachmentViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var recordingTimeLabel: UILabel!
    @IBOutlet var play_btn_ref: UIButton!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var attachmentImage: UIImageView!
    @IBOutlet weak var attachmentTypePickerButton: UIButton!
    @IBOutlet weak var closeAttachmentButton: UIButton!
    @IBOutlet weak var uploadAttachmentView: UIView! {
        didSet {
            uploadAttachmentView.setBorderShadow(color: UIColor.gray, shadowRadius: 1.0, shadowOpactiy: 1, shadowOffsetWidth: Int(0.5), shadowOffsetHeight: 1)
        }
    }
    @IBOutlet weak var attachmentPreviewImage: UIImageView!
    @IBOutlet weak var closeAttachmentPreviewView: UIButton!
    @IBOutlet weak var attachmentPreviewView: UIView! {
        didSet {
            attachmentPreviewView.setBorderShadow(color: UIColor.gray, shadowRadius: 1.0, shadowOpactiy: 1, shadowOffsetWidth: Int(0.5), shadowOffsetHeight: 1)
        }
    }
    @IBOutlet weak var addNewAttachmentButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var isUploadViewDisplayed = false
    var isPreviewDisplayed = false
    var typeName = [String]()
    var assignID = ""
    var mediaType = ""
    var mediaFile = ""
    var fileURL = ""
    var isUploadImage = Bool()
    
    @IBOutlet weak var addFileLabel: UILabel!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    var meterTimer:Timer!
    var isAudioRecordingGranted: Bool!
    var isRecording = false
    var isPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        populateData()
        updateView()
        check_record_permission()
        self.attachmentImage.isHidden = true
        self.takePhotoButton.isHidden = true
        self.addFileLabel.isHidden = true
        self.play_btn_ref.isHidden = true
        self.recordingTimeLabel.isHidden = true
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Attachment", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "AttachmentCell", bundle: nil), forCellReuseIdentifier: "attachmentSectionCellID")
        tableView.register(UINib(nibName: "AttachmentContentCell", bundle: nil), forCellReuseIdentifier: "attachmentContentCellID")
        addNewAttachmentButton.addTarget(self, action: #selector(addAttachment), for: .touchUpInside)
        closeAttachmentButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        attachmentTypePickerButton.addTarget(self, action: #selector(showTypePicker), for: .touchUpInside)
        takePhotoButton.addTarget(self, action: #selector(addImageAction), for: .touchUpInside)
        uploadButton.addTarget(self, action: #selector(uploadAction), for: .touchUpInside)
        closeAttachmentPreviewView.addTarget(self, action: #selector(closeAttachmentPreview), for: .touchUpInside)
    }
    @objc func closeAttachmentPreview() {
        isPreviewDisplayed = false
        isUploadViewDisplayed = false
        updateView()
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
    func populateData() {
        for typeMedia in ACData.ATTACHMENTDATA.mediaTypes {
            typeName.append(typeMedia.media_type_name)
        }
        tableView.reloadData()
    }
    @objc func closeView() {
        isUploadViewDisplayed = false
        isPreviewDisplayed = false
        updateView()
    }
    @objc func addAttachment() {
        isUploadViewDisplayed = true
        isPreviewDisplayed = false
        updateView()
    }
    @objc func addImageAction() {
        if isUploadImage {
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
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }))
            actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(actionsheet,animated: true, completion: nil)
        } else {

        }
    }
    @objc func showAttachmentPicker() {
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
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionsheet,animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        let newImage = selectedImage.resizeImage(30.0, opaque: false)
        let imageData = newImage.pngData()!
        let imageStr = imageData.base64EncodedString()
        mediaFile = imageStr
        attachmentImage.image = selectedImage
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func updateView() {
        if isUploadViewDisplayed && !isPreviewDisplayed {
            uploadAttachmentView.isHidden = false
            isUploadViewDisplayed = false
            attachmentPreviewView.isHidden = true
            isPreviewDisplayed = true
        } else if !isUploadViewDisplayed && isPreviewDisplayed {
            uploadAttachmentView.isHidden = true
            isUploadViewDisplayed = true
            attachmentPreviewView.isHidden = false
            isPreviewDisplayed = false
            attachmentPreviewImage.sd_setImage(
                with: URL(string: fileURL),
                placeholderImage: UIImage(named: "WeKiddoLogo"),
                options: .refreshCached
            )
        } else {
            uploadAttachmentView.isHidden = true
            isUploadViewDisplayed = true
            attachmentPreviewView.isHidden = true
            isPreviewDisplayed = true
        }
//        if isPreviewDisplayed {
//            attachmentPreviewView.isHidden = false
//            isPreviewDisplayed = false
//            attachmentPreviewImage.sd_setImage(
//                with: URL(string: fileURL),
//                placeholderImage: UIImage(named: "WeKiddoLogo"),
//                options: .refreshCached
//            )
//        } else {
//            attachmentPreviewView.isHidden = true
//            isPreviewDisplayed = true
//        }
    }
    @objc func uploadAction() {
        if isUploadImage {
            ACRequest.POST_ADD_NEW_ATTACHMENT(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, assignID: assignID, mediaType: self.mediaType, mediaFile: self.mediaFile, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: status)
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        } else {
            
            let parameter: Parameters = [
                "user_id": ACData.LOGINDATA.userID,
                "role": ACData.LOGINDATA.role,
                "assign_id": assignID,
                "media_type": "MT6"
            ]
            do {
                if FileManager.default.fileExists(atPath: getFileUrl().path)
                {
//                    let audioData = try Data(contentsOf: getFileUrl()) as Data
                    ACRequest.POST_ADD_NEW_ATTACHMENT_FILE(parameters: parameter, file: getFileUrl(), fileName: "media_file", fileParameter: "media_file", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
                        SVProgressHUD.dismiss()
                        ACAlert.show(message: status)
                    }) { (message) in
                        SVProgressHUD.dismiss()
                        ACAlert.show(message: message)
                    }
                }
                else
                {
                    ACAlert.show(message: "Audio file is missing.")
                }
            } catch {
                print("Unable to load data: \(error)")
            }
            /*
            if(isPlaying)
            {
                audioPlayer.stop()
                isPlaying = false
            }
            else
            {
                if FileManager.default.fileExists(atPath: getFileUrl().path)
                {
                    prepare_play()
                    audioPlayer.play()
                    isPlaying = true
                }
                else
                {
                    ACAlert.show(message: "Audio file is missing.")
                }
            }
            */
        }
    }
    @objc func showTypePicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Type -",
            rows: typeName,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.attachmentTypePickerButton.setTitle(value, for: .normal)
                if value == "Attachment" {
                    self.isUploadImage = true
                    self.attachmentImage.isHidden = false
                    self.takePhotoButton.isHidden = false
                    self.addFileLabel.isHidden = false
                    self.play_btn_ref.isHidden = true
                    self.recordingTimeLabel.isHidden = true
                } else {
                    self.isUploadImage = false
                    self.attachmentImage.isHidden = true
                    self.takePhotoButton.isHidden = true
                    self.addFileLabel.isHidden = true
                    self.play_btn_ref.isHidden = false
                    self.recordingTimeLabel.isHidden = false
                }
                self.mediaType = ACData.ATTACHMENTDATA.mediaTypes[indexes].media_type_id
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
}

extension AttachmentViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ACData.ATTACHMENTDATA.attachments.count != 0 && ACData.ATTACHMENTDATA.voiceNotes.count != 0 {
            return 2 + ACData.ATTACHMENTDATA.attachments.count + ACData.ATTACHMENTDATA.voiceNotes.count
        } else if ACData.ATTACHMENTDATA.attachments.count != 0 && ACData.ATTACHMENTDATA.voiceNotes.count == 0 {
            return 1 + ACData.ATTACHMENTDATA.attachments.count
        } else if ACData.ATTACHMENTDATA.attachments.count == 0 && ACData.ATTACHMENTDATA.voiceNotes.count != 0 {
            return 1 + ACData.ATTACHMENTDATA.voiceNotes.count
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if ACData.ATTACHMENTDATA.attachments.count != 0 && ACData.ATTACHMENTDATA.voiceNotes.count != 0 {
            if indexPath.row == 0 {
                return 33
            } else if indexPath.row > 0 && indexPath.row < ACData.ATTACHMENTDATA.attachments.count + 1 {
                return 44
            } else if indexPath.row == ACData.ATTACHMENTDATA.attachments.count + 1 {
                return 33
            } else {
                return 44
            }
        } else if ACData.ATTACHMENTDATA.attachments.count != 0 && ACData.ATTACHMENTDATA.voiceNotes.count == 0 {
            if indexPath.row == 0 {
                return 33
            } else {
                return 44
            }
        } else if ACData.ATTACHMENTDATA.attachments.count == 0 && ACData.ATTACHMENTDATA.voiceNotes.count != 0 {
            if indexPath.row == 0 {
                return 33
            } else {
                return 44
            }
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if ACData.ATTACHMENTDATA.attachments.count != 0 && ACData.ATTACHMENTDATA.voiceNotes.count != 0 {
            if indexPath.row == 0 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "attachmentSectionCellID", for: indexPath) as? AttachmentCell)!
                cell.cellConfig(isAttachment: true)
                return cell
            } else if indexPath.row > 0 && indexPath.row < ACData.ATTACHMENTDATA.attachments.count + 1 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "attachmentContentCellID", for: indexPath) as? AttachmentContentCell)!
                cell.isAttachment = true
                cell.detailObj = ACData.ATTACHMENTDATA.attachments[indexPath.row - 1]
                cell.delegate = self
                return cell
            } else if indexPath.row == ACData.ATTACHMENTDATA.attachments.count + 1 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "attachmentSectionCellID", for: indexPath) as? AttachmentCell)!
                cell.cellConfig(isAttachment: false)
                return cell
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "attachmentContentCellID", for: indexPath) as? AttachmentContentCell)!
                cell.isAttachment = false
                cell.delegate = self
                cell.voiceObj = ACData.ATTACHMENTDATA.voiceNotes[indexPath.row - (ACData.ATTACHMENTDATA.attachments.count + 2)]
                return cell
            }
        } else if ACData.ATTACHMENTDATA.attachments.count != 0 && ACData.ATTACHMENTDATA.voiceNotes.count == 0 {
            if indexPath.row == 0 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "attachmentSectionCellID", for: indexPath) as? AttachmentCell)!
                cell.cellConfig(isAttachment: true)
                return cell
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "attachmentContentCellID", for: indexPath) as? AttachmentContentCell)!
                cell.isAttachment = true
                cell.delegate = self
                cell.detailObj = ACData.ATTACHMENTDATA.attachments[indexPath.row - 1]
                return cell
            }
        } else if ACData.ATTACHMENTDATA.attachments.count == 0 && ACData.ATTACHMENTDATA.voiceNotes.count != 0 {
            if indexPath.row == 0 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "attachmentSectionCellID", for: indexPath) as? AttachmentCell)!
                cell.cellConfig(isAttachment: false)
                return cell
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "attachmentContentCellID", for: indexPath) as? AttachmentContentCell)!
                cell.isAttachment = false
                cell.delegate = self
                cell.voiceObj = ACData.ATTACHMENTDATA.voiceNotes[indexPath.row - 1]
                return cell
            }
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "attachmentContentCellID", for: indexPath) as? AttachmentContentCell)!
            return cell
        }
    }
}

extension AttachmentViewController: AttachmentContentCellDelegate {
    func refreshData() {
        ACRequest.POST_ATTACHMENT_ASSIGNMENT_DETAIL(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, assignID: ACData.ASSIGNMENTDETAILDATA.assignment_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (datas) in
            SVProgressHUD.dismiss()
            ACData.ATTACHMENTDATA = datas
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func previewImage(withURL: String) {
        fileURL = withURL
        isPreviewDisplayed = true
        isUploadViewDisplayed = false
        updateView()
    }
    func previewVoiceNote(withURL: String) {
        fileURL = withURL
        playVoice()
    }
    func playVoice() {
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileName = "voiceNotes"
            let fileURL = documentsURL.appendingPathComponent("\(fileName).m4a")
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        Alamofire.download(fileURL, to: destination).response { [weak self] (response) in
            
            if response.error == nil {
                
                guard let url = response.destinationURL else { return }
                
                do {
                    self?.audioPlayer = try AVAudioPlayer(contentsOf:  url)
                    self?.audioPlayer?.prepareToPlay()
                    self?.audioPlayer?.play()
                } catch {
                    print("Error:", error.localizedDescription)
                }
            }
        }
    }
}

extension AttachmentViewController: AVAudioRecorderDelegate, AVAudioPlayerDelegate {
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
}
