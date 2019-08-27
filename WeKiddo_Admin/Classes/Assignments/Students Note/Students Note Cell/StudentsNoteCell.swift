//
//  StudentsNoteCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 10/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class StudentsNoteCell: UITableViewCell {

    @IBOutlet weak var uploadAttachmentButton: UIButton!{
        didSet{
            uploadAttachmentButton.backgroundColor = ACColor.MAIN
            uploadAttachmentButton.layer.cornerRadius = 5
            uploadAttachmentButton.clipsToBounds = true
        }
    }
    @IBOutlet weak var attachmentCollection: UICollectionView!
    @IBOutlet weak var editNoteButton: UIButton!{
        didSet{
            editNoteButton.backgroundColor = ACColor.MAIN
            editNoteButton.layer.cornerRadius = 5
            editNoteButton.clipsToBounds = true
        }
    }
    @IBOutlet weak var noteLabel: UILabel!
    
    
    var noteObj: StudentNoteModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        editNoteButton.addTarget(self, action: #selector(editNoteAction), for: .touchUpInside)
        uploadAttachmentButton.addTarget(self, action: #selector(uploadAction), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = noteObj else { return }
        noteLabel.text = obj.note_content
    }
    @objc func editNoteAction() {
        
    }
    @objc func uploadAction() {
        
    }
}
