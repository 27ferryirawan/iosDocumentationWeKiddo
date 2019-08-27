//
//  MedicalRecordCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 14/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class MedicalRecordCell: UITableViewCell {

    
    @IBOutlet weak var medicalDateLbl: UILabel!
    @IBOutlet weak var doctorLbl: UILabel!
    @IBOutlet weak var hospitalLbl: UILabel!
    @IBOutlet weak var medicineLbl: UILabel!
    @IBOutlet weak var actionLbl: UILabel!
    @IBOutlet weak var symptomLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var medicalObjc: MedicalModel?{
        didSet{
            cellDataSet()
        }
    }
    
    func cellDataSet() {
        guard let medicalDate = medicalObjc?.medical_date, let doctor = medicalObjc?.doctor, let hospital = medicalObjc?.hospital, let medicine = medicalObjc?.medicine, let action = medicalObjc?.medical_action, let symptom = medicalObjc?.symptom else {
            return
        }
        medicalDateLbl.text = toDateString(time: medicalDate)
        doctorLbl.text = doctor
        hospitalLbl.text = hospital
        medicineLbl.text = medicine
        actionLbl.text = action
        symptomLbl.text = symptom
    }
    
    func toDateString(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        // then convert date to string again
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "dd MMM yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
    
    
    
}
