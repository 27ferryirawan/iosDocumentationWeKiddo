//
//  EBookDownloadedContentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 22/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class EBookDownloadedContentCell: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookDate: UILabel!
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var childName: UILabel!
    @IBOutlet weak var childImage: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    var detailObj: CoordinatorEbookDownloadListModel? {
        didSet {
            cellConfig()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellConfig() {
        guard let obj = detailObj else { return }
        self.childImage.sd_setImage(
            with: URL(string: (obj.child_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        childName.text = "\(obj.child_name)\nNIK \(obj.child_nis)\n\(obj.school_class)"
        bookName.text = "\(obj.book_name)"
        bookDate.text = convertDate(time: obj.download_date)
        self.bookImage.sd_setImage(
            with: URL(string: (obj.book_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
    
}

extension EBookDownloadedContentCell {
    func convertDate(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        // then convert date to string again
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "dd/MM/yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
