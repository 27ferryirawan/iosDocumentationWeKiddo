//
//  EditEventMonitoringViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 28/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import MapKit

class EditEventMonitoringViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var isFromEdit = Bool()
    var descCount = 0
    var mediaFile = ""
    var mediaType = ""
    var classID: String?
    var levelID: String?
    var selectedDescription = [DescriptionModel]()
    var mediaArray = [BannerMediaModel]()
    var galleryArray = [GalleryMediaModel]()
    var videoArray = [VideoMediaModel]()
    var isBanner = Bool()
    var isMedia = Bool()
    var isVideo = Bool()
    var titleHeader: String?
    var announcementDescText = ""
    var startDate: String?
    var endDate: String?
    var dueDate: String?
    var examDesc: String?
    var examAmount: String?
    var newDescTitle = ""
    var newDescDesc = ""
    var isEdit = Bool()
    var selectedAddressName: String?
    var selectedAddressDesc: String?
    var selectedAddressLat = 0.0
    var selectedAddressLong = 0.0
    var isAddDescViewDisplayed = false
    var mapView: MKMapView? = nil
    var eventID = ""
    var studentSelected = [StudentSearchSelected]()
    
    @IBOutlet weak var addDescBgView: UIView! {
        didSet {
            addDescBgView.setBorderShadow(color: UIColor.lightGray, shadowRadius: 2.0, shadowOpactiy: 1.0, shadowOffsetWidth: 2, shadowOffsetHeight: 2)
        }
    }
    @IBOutlet weak var addDescTitleText: UITextField!
    @IBOutlet weak var addDescDescText: UITextView! {
        didSet {
            addDescDescText.layer.borderColor = UIColor.lightGray.cgColor
            addDescDescText.layer.borderWidth = 1.0
            addDescDescText.layer.cornerRadius = 5.0
            addDescDescText.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var addDescButton: UIButton!{
        didSet{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        if isEdit {
            populateEditData()
        }
        updateView()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Edit Event", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "EditEventTopCell", bundle: nil), forCellReuseIdentifier: "editEventTopCellID")
        tableView.register(UINib(nibName: "EditEventDescCell", bundle: nil), forCellReuseIdentifier: "editEventDescCellID")
        tableView.register(UINib(nibName: "EditEventFooterCell", bundle: nil), forCellReuseIdentifier: "editEventFooterCellID")
        addDescButton.addTarget(self, action: #selector(addNewDesc), for: .touchUpInside)
    }
    func updateView() {
        if isAddDescViewDisplayed {
            addDescBgView.isHidden = false
        } else {
            addDescBgView.isHidden = true
        }
    }
    func populateEditData() {
        for item in ACData.APPROVALDETAILDATA.field {
            selectedDescription.append(DescriptionModel(title: item.title_text, description: item.desc))
        }
        var locationArray = ACData.APPROVALDETAILDATA.event_latlong.components(separatedBy: ",")
        selectedAddressLat = Double(locationArray[0])!
        selectedAddressLong = Double(locationArray[1])!
    }
}

extension EditEventMonitoringViewController: UITextFieldDelegate, UITextViewDelegate {
    @objc func addNewDesc() {
        descCount += 1
        selectedDescription.append(DescriptionModel(title: newDescTitle, description: newDescDesc))
        isAddDescViewDisplayed = false
        updateView()
        tableView.reloadData()
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.selectedDescription.count, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
        addDescDescText.resignFirstResponder()
        addDescTitleText.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newDescTitle = textField.text!
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        newDescTitle = textField.text!
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        newDescDesc = text
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
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
        newDescDesc = textView.text!
        if textView.text.isEmpty {
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
        }
    }
}

extension EditEventMonitoringViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + descCount
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 780
        } else if indexPath.row <= descCount {
            return 120
        } else {
            return 390
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
           let cell = (tableView.dequeueReusableCell(withIdentifier: "editEventTopCellID", for: indexPath) as? EditEventTopCell)!
            
            if isEdit {

                for mediaObj in ACData.ATTACHMENTBANNERDATA {
                    if mediaObj.file_type == "MT3" {
                        cell.mediaArray.append(BannerMediaModel(fileID: mediaObj.file_id, fileURL: mediaObj.file_url, fileType: mediaObj.file_type))
                        self.mediaArray = cell.mediaArray
                    }
                }
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(self.mediaArray) {
                    let defaults = UserDefaults.standard
                    defaults.set(encoded, forKey: "bannerMediaSelected")
                }
                
                cell.detailObjEdit = ACData.APPROVALDETAILDATA
            }
            else {
                cell.bannerPhotoCollectiob.reloadData()
                //            cell.locationManager.startUpdatingLocation()
                cell.descHeaderText.text = "\(selectedAddressName ?? ACData.APPROVALDETAILDATA.address)"
                let myAnnotation: MKPointAnnotation = MKPointAnnotation()
                myAnnotation.coordinate = CLLocationCoordinate2DMake(selectedAddressLat, selectedAddressLong)
                myAnnotation.title = "Current location"
                cell.mapView.addAnnotation(myAnnotation)
            }

            cell.delegate = self
            return cell
        } else if indexPath.row <= descCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "editEventDescCellID", for: indexPath) as? EditEventDescCell)!
            cell.detailObj = selectedDescription[indexPath.row - 1]
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "editEventFooterCellID", for: indexPath) as? EditEventFooterCell)!
            if isEdit {
                if isMedia {
                    for mediaObj in ACData.ATTACHMENTIMAGEMEDIADATA {
                        if mediaObj.media_type_id == "MT2" {
                            cell.galleryArray.append(GalleryMediaModel(fileID: mediaObj.media_id, fileURL: mediaObj.url, fileType: mediaObj.media_type_id))
                            self.galleryArray = cell.galleryArray
                        }
                    }
                    let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode(self.galleryArray) {
                        let defaults = UserDefaults.standard
                        defaults.set(encoded, forKey: "galleryMediaSelected")
                    }
                } else if isVideo {
                    for mediaObj in ACData.ATTACHMENTVIDEOMEDIADATA {
                        if mediaObj.file_type_id == "MT1" {
                            cell.videoArray.append(VideoMediaModel(fileID: mediaObj.file_id, fileURL: mediaObj.file_url, fileType: mediaObj.file_type_id))
                            self.videoArray = cell.videoArray
                        }
                    }
                    let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode(self.videoArray) {
                        let defaults = UserDefaults.standard
                        defaults.set(encoded, forKey: "videoMediaSelected")
                    }
                }
                cell.detailObjEdit = ACData.APPROVALDETAILDATA
            } else {
                cell.pictureCollection.reloadData()
                cell.videoCollection.reloadData()
            }
            cell.isEdit = self.isEdit
            cell.delegate = self
            return cell
        }
    }
}

extension EditEventMonitoringViewController: EditEventTopCellDelegate, EditEventFooterCellDelegate, SearchLocationViewControllerDelegate {
    func updateLocationWithValue(name: String, desc: String, lat: Double, long: Double){
        selectedAddressName = name
        selectedAddressDesc = desc
        selectedAddressLat = lat
        selectedAddressLong = long
        tableView.reloadData()
    }
    func toSearchStudentPage(withStudentsLists: [StudentSearchSelected]) {
        
    }
    func toSearchAddress(withMap: MKMapView) {
        let searchAddressVC = SearchLocationViewController()
        searchAddressVC.mapView = withMap
        searchAddressVC.delegate = self
        self.navigationController?.pushViewController(searchAddressVC, animated: true)
    }
    func addNewEvent() {
        /*
        print("Header Title: \(titleHeader) \n\n Banner photos: \(ACData.ATTACHMENTBANNERDATA.count) \n\n Start Date: \(startDate) \n\n End Date: \(endDate) \n\n Announcement Desc: \(announcementDescText) \n\n Desc Array: \(selectedDescription) \n\n Media Image: \(ACData.ATTACHMENTIMAGEMEDIADATA.count) \n\n Media Video: \(ACData.ATTACHMENTVIDEOMEDIADATA.count) \n\n Target Audience Level: \(levelID) \n\n Target Audience Class: \(classID) \n\n Student: \(studentSelected)")
        */
        
        var bannerOn = "["
        var imageOn = "["
        var videoOn = "["
        var additionalOn = "["
        if isEdit {
            if let bannerData = UserDefaults.standard.data(forKey: "bannerMediaSelected") {
                let placeArray = try! JSONDecoder().decode([BannerMediaModel].self, from: bannerData)
                mediaArray = placeArray
            } else {
                print("No data at the moment")
            }

            if let galleryData = UserDefaults.standard.data(forKey: "galleryMediaSelected") {
                let selectedGalleryArray = try! JSONDecoder().decode([GalleryMediaModel].self, from: galleryData)
                galleryArray = selectedGalleryArray
            } else {
                print("No data at the moment")
            }

            if let videoData = UserDefaults.standard.data(forKey: "videoMediaSelected") {
                let selectedVideoArray = try! JSONDecoder().decode([VideoMediaModel].self, from: videoData)
                videoArray = selectedVideoArray
            } else {
                print("No data at the moment")
            }
            
            if mediaArray.count != 0 {
                var i = 0
                for data in mediaArray {
                    if i > 0 {
                        bannerOn += ","
                    }
                    bannerOn += "{"
                    bannerOn += "\"id\":\"\(data.file_id)\""
                    bannerOn += "}"
                    
                    i += 1
                }
            }
            
            if galleryArray.count != 0 {
                var i = 0
                for data in galleryArray {
                    if i > 0 {
                        imageOn += ","
                    }
                    imageOn += "{"
                    imageOn += "\"id\":\"\(data.file_id)\""
                    imageOn += "}"
                    
                    i += 1
                }
            }

            if videoArray.count != 0 {
                var i = 0
                for data in videoArray {
                    if i > 0 {
                        videoOn += ","
                    }
                    videoOn += "{"
                    videoOn += "\"id\":\"\(data.file_id)\""
                    videoOn += "}"
                    
                    i += 1
                }
            }

        } else {
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
        
        let newAdditionalAddOn = additionalOn.replacingOccurrences(of: "\\", with: "")
        let jsonAdditionalData = newAdditionalAddOn.data(using: .utf8)!
        let jsonAdditional = try! JSONSerialization.jsonObject(with: jsonAdditionalData, options: .allowFragments)
        
        if isEdit {
            eventID = ACData.APPROVALDETAILDATA.event_id
        } else {
            eventID = ""
        }
        
        let parameters: Parameters = [
            "user_id":ACData.LOGINDATA.userID,
            "role":ACData.LOGINDATA.role,
            "school_id":ACData.LOGINDATA.school_id,
            "year_id":ACData.LOGINDATA.year_id,
            "event_id":eventID,
            "event_title":titleHeader ?? ACData.APPROVALDETAILDATA.event_name,
            "event_desc":examDesc ?? ACData.APPROVALDETAILDATA.desc,
            "banner_list":jsonBanner,
            "content_list":jsonImage,
            "video_list":jsonVideo,
            "level":levelID ?? ACData.APPROVALDETAILDATA.school_level_id,
            "class":classID ?? ACData.APPROVALDETAILDATA.school_class_id,
            "additionals":jsonAdditional,
            "start_event_date":startDate ?? ACData.APPROVALDETAILDATA.start_event_date,
            "end_event_date":endDate ?? ACData.APPROVALDETAILDATA.end_event_date,
            "event_due_date":dueDate ?? ACData.APPROVALDETAILDATA.event_due_date,
            "event_latlong":"\(selectedAddressLat),\(selectedAddressLong)",
            "amount":examAmount ?? ACData.APPROVALDETAILDATA.amount,
            "address":"\(selectedAddressName ?? ACData.APPROVALDETAILDATA.address),\(selectedAddressDesc ?? "")"
        ]
        print(parameters)
        ACRequest.POST_ADD_NEW_EVENT(params: parameters, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: status)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func showAddDescPopUp() {
        isAddDescViewDisplayed = true
        updateView()
    }
    func staticDescFilled(withString: String) {
        examDesc = withString
    }
    func amountFilled(withString: String) {
        examAmount = withString
    }
    func dueDateSelected(withDate: String) {
        dueDate = withDate
    }
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
    func sendSelectedStudent(withStudentArray: [StudentSearchSelected]) {
        print("hasil jadi: \(withStudentArray)")
        for index in withStudentArray {
            print(index.child_id)
        }
        studentSelected = withStudentArray
        self.tableView.reloadRows(at: [IndexPath(row: 1 + self.descCount, section: 0)], with: UITableView.RowAnimation.none)
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

extension EditEventMonitoringViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        if isEdit {
            let parameter: Parameters = [
                "user_id": ACData.LOGINDATA.userID,
                "role": ACData.LOGINDATA.role,
                "school_id": ACData.LOGINDATA.school_id,
                "year_id": ACData.LOGINDATA.year_id,
                "event_id": ACData.APPROVALDETAILDATA.event_id,
                "media_type": mediaType
            ]
            print(parameter)
            ACRequest.POST_UPLOAD_NEW_VIDEO_ATTACHMENT_EVENT_MONITORING(parameters: parameter, file: withURL, fileName: "media_file", fileParameter: "media_file", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
                SVProgressHUD.dismiss()
                ACData.ATTACHMENTVIDEOMEDIADATA = status
                DispatchQueue.main.async {
                    self.tableView.reloadRows(at: [IndexPath(row: 1 + self.descCount, section: 0)], with: UITableView.RowAnimation.none)
                }
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        } else {
            let parameter: Parameters = [
                "user_id": ACData.LOGINDATA.userID,
                "role": ACData.LOGINDATA.role,
                "school_id": ACData.LOGINDATA.school_id,
                "year_id": ACData.LOGINDATA.year_id,
                "media_type": mediaType
            ]
            print(parameter)
            ACRequest.POST_UPLOAD_FILE_EVENT_VIDEO_ATTACHMENT_EVENT_MONITORING(parameters: parameter, file: withURL, fileName: "media_file", fileParameter: "media_file", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
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
    }
    func uploadAttachment(withImage: UIImage) {
        if isEdit {
            let parameter: Parameters = [
                "user_id": ACData.LOGINDATA.userID,
                "role": ACData.LOGINDATA.role,
                "school_id": ACData.LOGINDATA.school_id,
                "year_id": ACData.LOGINDATA.year_id,
                "event_id": ACData.APPROVALDETAILDATA.event_id,
                "media_type": mediaType
            ]
            if isBanner {
                ACRequest.POST_UPLOAD_NEW_IMAGE_ATTACHMENT_EVENT_MONITORING(parameters: parameter, file: withImage, fileName: "media_file", fileParameter: "media_file", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
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
                ACRequest.POST_UPLOAD_NEW_IMAGE_MEDIA_ATTACHMENT_EVENT_MONITORING(parameters: parameter, file: withImage, fileName: "media_file", fileParameter: "media_file", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
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
        } else {
            let parameter: Parameters = [
                "user_id": ACData.LOGINDATA.userID,
                "role": ACData.LOGINDATA.role,
                "school_id": ACData.LOGINDATA.school_id,
                "year_id": ACData.LOGINDATA.year_id,
                "media_type": mediaType
            ]
            if isBanner {
                ACRequest.POST_UPLOAD_FILE_EVENT_BANNER_ATTACHMENT_EVENT_MONITORING(parameters: parameter, file: withImage, fileName: "media_file", fileParameter: "media_file", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
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
                ACRequest.POST_UPLOAD_FILE_EVENT_MEDIA_ATTACHMENT_EVENT_MONITORING(parameters: parameter, file: withImage, fileName: "media_file", fileParameter: "media_file", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
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
}
