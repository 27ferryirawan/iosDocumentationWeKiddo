//
//  AddAnnouncementViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 17/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class AddAnnouncementViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var isFromEdit = Bool()
    var descCount = 0
    var mediaFile = ""
    var mediaType = ""
    var classID = ""
    var levelID = ""
    var selectedDescription = [DescriptionModel]()
    var isBanner = Bool()
    var isMedia = Bool()
    var isVideo = Bool()
    var titleHeader = ""
    var announcementDescText = ""
    var startDate = ""
    var endDate = ""
    var studentSelected = [StudentSearchSelected]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Add Announcement", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "AddAnnouncementCell", bundle: nil), forCellReuseIdentifier: "addAnnouncementCellID")
        tableView.register(UINib(nibName: "AddAnnouncementDescCell", bundle: nil), forCellReuseIdentifier: "addAnnouncementDescCellID")
        tableView.register(UINib(nibName: "AddAnnouncementHeaderCell", bundle: nil), forCellReuseIdentifier: "addAnnouncementHeaderCellID")
    }
}

extension AddAnnouncementViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + descCount
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 370
        } else if indexPath.row <= descCount {
            return 160
        } else {
            return 560
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addAnnouncementCellID", for: indexPath) as? AddAnnouncementCell)!
//            cell.detailObj = AttachmentBannerModel
            cell.titleText.text = self.titleHeader
            cell.bannerPhotoCollectiob.reloadData()
            cell.delegate = self
            return cell
        } else if indexPath.row <= descCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addAnnouncementDescCellID", for: indexPath) as? AddAnnouncementDescCell)!
            cell.index = indexPath.row - 1
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addAnnouncementHeaderCellID", for: indexPath) as? AddAnnouncementHeaderCell)!
            cell.studentLists = studentSelected
            cell.pictureCollection.reloadData()
            cell.videoCollection.reloadData()
            cell.studentCollection.reloadData()
            cell.delegate = self
            return cell
        }
    }
}

extension AddAnnouncementViewController: AddAnnouncementHeaderCellDelegate, AddAnnouncementCellDelegate, AddAnnouncementDescCellDelegate, AddDetentionStudentSearchViewControllerDelegate {
    func refreshExamRemedyTableWithIndex(index: String) {
        
    }
    func openImageGallery() {
        isBanner = false
        isMedia = true
        isVideo = false
        mediaType = "MT2"
        openBannerPicker()
    }
    func openVideoGallery() {
        isBanner = false
        isMedia = false
        isVideo = true
        mediaType = "MT1"
        openBannerPicker()
    }
    func levelSelected(withValue: String) {
        print(withValue)
        levelID = withValue
    }
    func classSelected(withValue: String) {
        print(withValue)
        classID = withValue
    }
    func addAnnouncement() {
        print("Header Title: \(titleHeader) \n\n Banner photos: \(ACData.ATTACHMENTBANNERDATA.count) \n\n Start Date: \(startDate) \n\n End Date: \(endDate) \n\n Announcement Desc: \(announcementDescText) \n\n Desc Array: \(selectedDescription) \n\n Media Image: \(ACData.ATTACHMENTIMAGEMEDIADATA.count) \n\n Media Video: \(ACData.ATTACHMENTVIDEOMEDIADATA.count) \n\n Target Audience Level: \(levelID) \n\n Target Audience Class: \(classID) \n\n Student: \(studentSelected)")
        
        var bannerOn = "["
        var imageOn = "["
        var videoOn = "["
        var studentOn = "["
        var additionalOn = "["

        if ACData.ATTACHMENTBANNERDATA.count != 0 {
            var i = 0
            for data in ACData.ATTACHMENTBANNERDATA {
                if i > 0 {
                    bannerOn += ","
                }
                bannerOn += "{"
                bannerOn += "\"id\":\"\(data.file_id)\""
                bannerOn += "}"
                
                i += 1
            }
        }
        
        if ACData.ATTACHMENTIMAGEMEDIADATA.count != 0 {
            var i = 0
            for data in ACData.ATTACHMENTIMAGEMEDIADATA {
                if i > 0 {
                    imageOn += ","
                }
                imageOn += "{"
                imageOn += "\"id\":\"\(data.media_id)\""
                imageOn += "}"
                
                i += 1
            }
        }
        
        if ACData.ATTACHMENTVIDEOMEDIADATA.count != 0 {
            var i = 0
            for data in ACData.ATTACHMENTVIDEOMEDIADATA {
                if i > 0 {
                    videoOn += ","
                }
                videoOn += "{"
                videoOn += "\"id\":\"\(data.file_id)\""
                videoOn += "}"
                
                i += 1
            }
        }

        if studentSelected.count != 0 {
            var i = 0
            for data in studentSelected {
                if i > 0 {
                    studentOn += ","
                }
                studentOn += "{"
                studentOn += "\"child_id\":\"\(data.child_id)\""
                studentOn += "}"
                
                i += 1
            }
        }
        
        if selectedDescription.count != 0 {
            var i = 0
            for data in selectedDescription {
                if i > 0 {
                    additionalOn += ","
                }
                additionalOn += "{"
                additionalOn += "\"title_text\":\"\(data.titleText)\","
                additionalOn += "\"desc\":\"\(data.descText)\""
                additionalOn += "}"
                
                i += 1
            }
        }
        
        bannerOn += "]"
        imageOn += "]"
        videoOn += "]"
        studentOn += "]"
        additionalOn += "]"
        
        let newBannerAddOn = bannerOn.replacingOccurrences(of: "\\", with: "")
        let jsonBannerData = newBannerAddOn.data(using: .utf8)!
        let jsonBanner = try! JSONSerialization.jsonObject(with: jsonBannerData, options: .allowFragments)
        
        let newImageAddOn = imageOn.replacingOccurrences(of: "\\", with: "")
        let jsonImageData = newImageAddOn.data(using: .utf8)!
        let jsonImage = try! JSONSerialization.jsonObject(with: jsonImageData, options: .allowFragments)
        
        let newVideoAddOn = videoOn.replacingOccurrences(of: "\\", with: "")
        let jsonVideoData = newVideoAddOn.data(using: .utf8)!
        let jsonVideo = try! JSONSerialization.jsonObject(with: jsonVideoData, options: .allowFragments)

        let newStudentAddOn = studentOn.replacingOccurrences(of: "\\", with: "")
        let jsonStudentData = newStudentAddOn.data(using: .utf8)!
        let jsonStudent = try! JSONSerialization.jsonObject(with: jsonStudentData, options: .allowFragments)

        let newAdditionalAddOn = additionalOn.replacingOccurrences(of: "\\", with: "")
        let jsonAdditionalData = newAdditionalAddOn.data(using: .utf8)!
        let jsonAdditional = try! JSONSerialization.jsonObject(with: jsonAdditionalData, options: .allowFragments)
        
        //TODO : Change Value of schoolID and yearID
        
        let parameters: Parameters = [
            "user_id":ACData.LOGINDATA.userID,
            "school_id":ACData.LOGINDATA.dashboardSchoolMenu.last?.school_id ?? "",
            "year_id":ACData.LOGINDATA.dashboardSchoolMenu.last?.year_id ?? "",
            "announcement_id":"",
            "announcement_title":titleHeader,
            "announcement_desc":announcementDescText,
            "banner_list":jsonBanner,
            "content_list":jsonImage,
            "video_list":jsonVideo,
            "level":levelID,
            "class":classID,
            "childs":jsonStudent,
            "additionals":jsonAdditional,
            "start_date":startDate,
            "end_date":endDate
        ]
        
        ACRequest.POST_ADD_NEW_ANNOUNCEMENT_STUDENT(params: parameters, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: status)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func sendSelectedStudent(withStudentArray: [StudentSearchSelected]) {
        print("hasil jadi: \(withStudentArray)")
        for index in withStudentArray {
            print(index.child_id)
        }
        studentSelected = withStudentArray
        self.tableView.reloadRows(at: [IndexPath(row: 1 + self.descCount, section: 0)], with: UITableView.RowAnimation.none)
    }
    func toSearchStudentPage(withStudentsLists: [StudentSearchSelected]) {
        let searchVC = AddDetentionStudentSearchViewController()
        searchVC.studentList = studentSelected
        searchVC.isFromAnnouncement = true
        searchVC.isFromEventPayment = false
        searchVC.isFromExamRemedy = false
        searchVC.classID = self.classID
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(studentSelected) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "studentSelected")
        }
        searchVC.delegate = self
        let navVC = UINavigationController(rootViewController: searchVC)
        self.navigationController?.present(navVC, animated: true, completion: nil)
    }
    func headerTextFilled(withString: String, withIndex: Int) {
        print("index additional: \(withIndex)")
        selectedDescription[withIndex].titleText = withString
    }
    func descTextFilled(withString: String, withIndex: Int) {
        print("index additional: \(withIndex)")
        selectedDescription[withIndex].descText = withString
    }
    func showBannerPicker() {
        isBanner = true
        isMedia = false
        isVideo = false
        mediaType = "MT3"
        openBannerPicker()
    }
    func titleHeaderFilled(withString: String) {
        print(withString)
        titleHeader = withString
    }
    func publishDateSelected(withDate: String) {
        print(withDate)
        startDate = withDate
    }
    func endDateSelected(withDate: String) {
        print(withDate)
        endDate = withDate
    }
    func descFilled(withString: String) {
        print(withString)
        announcementDescText = withString
    }
    func addMoreDesc() {
        descCount += 1
        selectedDescription.append(DescriptionModel(title: "0", description: "0"))
        tableView.reloadData()
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.selectedDescription.count, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
        print(selectedDescription)
    }
}

extension AddAnnouncementViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func openBannerPicker() {
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
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if isBanner || isMedia {
            guard let selectedImage = info[.originalImage] as? UIImage else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            }
                let newImage = selectedImage.resizeImage(30.0, opaque: false)
                picker.dismiss(animated: true) {
                    self.uploadAttachment(withImage: newImage)
                }
        } else {
            guard let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL else {
                return
            }
            do {
                let data = try Data(contentsOf: videoUrl, options: .mappedIfSafe)
                print(data)
                picker.dismiss(animated: true) {
                    self.uploadVideo(withURL: data)
                }
            } catch  {
                
            }
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func uploadVideo(withURL: Data) {
        //TODO : Change value of schoolID and yearID
        let parameter: Parameters = [
            "user_id": ACData.LOGINDATA.userID,
            "school_id": ACData.LOGINDATA.dashboardSchoolMenu.last?.school_id ?? "",
            "year_id": ACData.LOGINDATA.dashboardSchoolMenu.last?.year_id ?? "",
            "media_type": mediaType
        ]
        print(parameter)
        ACRequest.POST_UPLOAD_NEW_VIDEO_ATTACHMENT_ANNOUNCEMENT(parameters: parameter, file: withURL, fileName: "media_file", fileParameter: "media_file", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            ACData.ATTACHMENTVIDEOMEDIADATA = status
            DispatchQueue.main.async {
                self.tableView.reloadRows(at: [IndexPath(row: 1 + self.descCount, section: 0)], with: UITableView.RowAnimation.none)
            }
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func uploadAttachment(withImage: UIImage) {
        let parameter: Parameters = [
            //TODO: Change value of SchoolID and yearID
            "user_id": ACData.LOGINDATA.userID,
            "school_id": ACData.LOGINDATA.dashboardSchoolMenu.last?.school_id ?? "",
            "year_id": ACData.LOGINDATA.dashboardSchoolMenu.last?.year_id ?? "",
            "media_type": mediaType
        ]
        if isBanner {
            ACRequest.POST_UPLOAD_NEW_ATTACHMENT_ANNOUNCEMENT(parameters: parameter, file: withImage, fileName: "media_file", fileParameter: "media_file", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
                ACData.ATTACHMENTBANNERDATA = status
                print(ACData.ATTACHMENTBANNERDATA.count)
                SVProgressHUD.dismiss()
                DispatchQueue.main.async {
                    self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.none)
                }
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        } else {
            ACRequest.POST_UPLOAD_NEW_IMAGE_MEDIA_ATTACHMENT_ANNOUNCEMENT(parameters: parameter, file: withImage, fileName: "media_file", fileParameter: "media_file", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
                ACData.ATTACHMENTIMAGEMEDIADATA = status
                print(ACData.ATTACHMENTIMAGEMEDIADATA.count)
                SVProgressHUD.dismiss()
                DispatchQueue.main.async {
                    self.tableView.reloadRows(at: [IndexPath(row: 1 + self.descCount, section: 0)], with: UITableView.RowAnimation.none)
                }
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        }
    }
}
