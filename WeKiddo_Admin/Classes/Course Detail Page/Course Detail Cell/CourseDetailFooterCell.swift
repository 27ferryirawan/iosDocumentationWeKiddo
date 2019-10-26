//
//  CourseDetailFooterCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 26/10/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import MapKit

protocol CourseDetailFooterCellDelegate: class {
    func toRegister()
}

class CourseDetailFooterCell: UITableViewCell {
    @IBOutlet weak var registerCourseButton: UIButton!
    @IBOutlet weak var courseMap: MKMapView!
    @IBOutlet weak var courseAddress: UILabel!
    @IBOutlet weak var courseInstagram: UILabel!
    @IBOutlet weak var courseLinkedIn: UILabel!
    @IBOutlet weak var courseFacebook: UILabel!
    @IBOutlet weak var courseEmail: UILabel!
    @IBOutlet weak var coursePhone: UILabel!
    var detailObj: CourseDetailModel? {
        didSet {
            cellConfig()
        }
    }
    weak var delegate: CourseDetailFooterCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCourseButton.addTarget(self, action: #selector(register), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func register() {
        self.delegate?.toRegister()
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        coursePhone.text = "Telp : \(obj.course_phone)"
        courseEmail.text = "Email : \(obj.course_email)"
        courseFacebook.text = obj.course_facebook
        courseLinkedIn.text = obj.course_linkedin
        courseInstagram.text = obj.course_instagram
        courseAddress.text = obj.course_address
        let lat = Double(obj.course_lat)!
        let long = Double(obj.course_long)!
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        annotation.title = obj.course_name
        courseMap.addAnnotation(annotation)
    }
}
