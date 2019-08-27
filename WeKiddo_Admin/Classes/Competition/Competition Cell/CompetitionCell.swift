//
//  CompetitionCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 14/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class CompetitionCell: UITableViewCell {
    @IBOutlet weak var competitionCategoryButton: UIButton!
    @IBOutlet weak var competitionLocationLabel: UILabel!
    @IBOutlet weak var competitionRegisterLabel: UILabel!
    @IBOutlet weak var competitionStartLabel: UILabel!
    @IBOutlet weak var competitionTitleLabel: UILabel!
    @IBOutlet weak var competitionImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(index: Int) {
        let object = ACData.COMPETITIONDATA[index]
        
        competitionTitleLabel.text = object.competition_name
        competitionStartLabel.text = convertDate(time: object.registration_date)
        competitionRegisterLabel.text = "\(convertDateAppend(time: object.competition_start_date))-\(convertDateAppend(time: object.competition_end_date))\(getYear(time: object.competition_end_date))"
        competitionLocationLabel.text = object.competition_city
        
        competitionImage.sd_setImage(
            with: URL(string: object.competition_image),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
}

extension CompetitionCell {
    func convertDate(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        // then convert date to string again
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "dd MMMM yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
    func convertDateAppend(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd MMMM yyyy"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        // then convert date to string again
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "dd MMMM"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
    func getYear(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd MMMM yyyy"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        // then convert date to string again
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
 }
