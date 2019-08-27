//
//  AttachmentContentCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 10/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol AttachmentContentCellDelegate: class {
    func refreshData()
    func previewImage(withURL: String)
    func previewVoiceNote(withURL: String)
}

class AttachmentContentCell: UITableViewCell {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var imageStatus: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageType: UIImageView!
    var attachID = 0
    var isAttachment = Bool()
    weak var delegate: AttachmentContentCellDelegate?
    var detailObj: AttachmentListModel? {
        didSet {
            cellConfig()
        }
    }
    var voiceObj: VoiceNoteListModel? {
        didSet {
            cellVoiceConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        deleteButton.addTarget(self, action: #selector(deleteAttachmentAction), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellVoiceConfig() {
        guard let obj = voiceObj else { return }
        nameLabel.text = "Voice Notes \(obj.media_id)"
        imageType.image = UIImage(named: "icon_note")
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        nameLabel.text = "Attachment \(obj.media_id)"
        imageType.image = UIImage(named: "ic_attach")
    }
    @IBAction func downloadAction(_ sender: UIButton) {
        guard let obj = detailObj else { return }
        loadFileAsync(url: URL(string: obj.url)!) { (status) in
            if status {
                print("sukses")
            } else {
                print("gagal")
            }
        }
    }
    @objc func deleteAttachmentAction() {
        if isAttachment {
            guard let obj = detailObj else { return }
            attachID = obj.media_id
        } else {
            guard let obj = voiceObj else { return }
            attachID = obj.media_id
        }
        ACRequest.POST_DELETE_ATTACHMENT_ASSIGNMENT(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, attachmentID: attachID, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            self.delegate?.refreshData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    @IBAction func previewFile(_ sender: UIButton) {
        /*
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        print(documentsDirectory)
        */
        if isAttachment {
            guard let obj = detailObj else { return }
            attachID = obj.media_id
            self.delegate?.previewImage(withURL: obj.url)
        } else {
            guard let obj = voiceObj else { return }
            attachID = obj.media_id
            self.delegate?.previewVoiceNote(withURL: obj.url)
        }
    }
    func loadFileAsync(url: URL, completion: @escaping (Bool) -> Void) {
        // create your document folder url
        let documentsUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        // your destination file url
        let destination = documentsUrl.appendingPathComponent(url.lastPathComponent)
        print("downloading file from URL: \(url.absoluteString)")
        if FileManager().fileExists(atPath: destination.path) {
            print("The file already exists at path, deleting and replacing with latest")
            
            if FileManager().isDeletableFile(atPath: destination.path) {
                do {
                    try FileManager().removeItem(at: destination)
                    print("previous file deleted")
                    if url.lastPathComponent == ".jpg" || url.lastPathComponent == ".png" {
                        self.saveImage(url: url, destination: destination) { (complete) in
                            if complete {
                                completion(true)
                            } else {
                                completion(false)
                            }
                        }
                    } else {
                        self.saveFile(url: url, destination: destination) { (complete) in
                            if complete {
                                completion(true)
                            } else {
                                completion(false)
                            }
                        }
                    }
                } catch {
                    print("current file could not be deleted")
                }
            }
        } else {
            if url.lastPathComponent == ".jpg" || url.lastPathComponent == ".png" {
                self.saveImage(url: url, destination: destination) { (complete) in
                    if complete {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            } else {
                self.saveFile(url: url, destination: destination) { (complete) in
                    if complete {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            }
        }
    }
    func saveImage(url: URL, destination: URL, completion: @escaping (Bool) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            completion(true)
        }.resume()
    }
    func saveFile(url: URL, destination: URL, completion: @escaping (Bool) -> Void) {
        URLSession.shared.downloadTask(with: url, completionHandler: { (location, response, error) in
            // after downloading your data you need to save it to your destination url
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let location = location, error == nil
                else { print("error with the url response"); completion(false); return}
            do {
//                print(response)
                try FileManager.default.moveItem(at: location, to: destination)
                print("new file saved")
                completion(true)
            } catch {
                print("file could not be saved: \(error)")
                completion(false)
            }
        }).resume()
    }
}
