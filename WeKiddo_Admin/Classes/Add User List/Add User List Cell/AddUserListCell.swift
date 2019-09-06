//
//  AddUserListCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 06/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class AddUserListCell: UITableViewCell {

    @IBOutlet weak var addNewClassButton: UIButton!
    @IBOutlet weak var classButton: UIButton!
    @IBOutlet weak var positionButton: UIButton!
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var imageCollection: UICollectionView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var nipText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var selectSchoolButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectSchoolButton.addTarget(self, action: #selector(showSchoolPicker), for: .touchUpInside)
        addPhotoButton.addTarget(self, action: #selector(showImagePicker), for: .touchUpInside)
        genderButton.addTarget(self, action: #selector(showGenderPicker), for: .touchUpInside)
        positionButton.addTarget(self, action: #selector(showPositionPicker), for: .touchUpInside)
        classButton.addTarget(self, action: #selector(showClassPicker), for: .touchUpInside)
        addNewClassButton.addTarget(self, action: #selector(addNewAction), for: .touchUpInside)
        imageCollection.register(UINib(nibName: "AddUserProfileImageCell", bundle: nil), forCellWithReuseIdentifier: "addUserProfileImageCellID")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func showSchoolPicker() {
    
    }
    @objc func showImagePicker() {
        
    }
    @objc func showGenderPicker() {
        
    }
    @objc func showPositionPicker() {
        
    }
    @objc func showClassPicker() {
        
    }
    @objc func addNewAction() {
        
    }
}

extension AddUserListCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddUserListCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "addUserProfileImageCellID", for: indexPath) as? AddUserProfileImageCell)!
        
        return cell
    }
}
