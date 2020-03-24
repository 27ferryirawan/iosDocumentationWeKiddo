//
//  EBookContentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 22/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class EBookContentCell: UITableViewCell {

    @IBOutlet weak var bookSource: UILabel!
    @IBOutlet weak var bookTotalView: UILabel!
    @IBOutlet weak var bookTotalDownload: UILabel!
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    var detailObj: CoordinatorEbookUploadListModel? {
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
        bookName.text = obj.book_name
        bookTotalDownload.text = "Downloaded : \(obj.total_download)"
        bookTotalView.text = "View : \(obj.total_view)"
        bookSource.text = obj.source == 1 ? "Source : Upload" : "Source : From Master"
        self.bookImage.sd_setImage(
            with: URL(string: (obj.book_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
    
}
