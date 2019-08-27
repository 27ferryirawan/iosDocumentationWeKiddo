//
//  OnboardingCollectionCell.swift
//  WeKiddo
//
//  Created by Ferry Irawan on 22/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol OnboardingCollectionDelegate: class {
    func toLogin()
    //    func carouselState(state : Int)
}

class OnboardingCollectionCell: UICollectionViewCell{
    
    @IBOutlet weak var continueBtn: UIButton!{
        didSet{
            continueBtn.layer.cornerRadius = 20
            continueBtn.clipsToBounds = true
        }
    }
    @IBOutlet weak var onboardingImage: UIImageView!
    @IBOutlet weak var onboardingLbl: UILabel!
    @IBOutlet weak var onboaradingDescLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        continueBtn.addTarget(self, action: #selector(toLoginPage), for: .touchUpInside)
    }
    weak var delegate: OnboardingCollectionDelegate?
    func configCell(index: Int) {
        switch index {
        case 0:
            onboardingImage.image = UIImage(named: "slide_image_1")
            onboardingLbl.text = "Apa sih WeKiddo?"
            onboaradingDescLbl.text = "WeKiddo merupakan sebuah platform teknologi yang memudahkan orang tua untuk mengambil andil penuh terhadap perkembangan anak dalam genggaman tangan"
            continueBtn.isHidden = true
        //            self.delegate?.carouselState(state: index)
        case 1:
            onboardingImage.image = UIImage(named: "slide_image_2")
            onboardingLbl.text = "Sebuah hasil karya anak bangsa"
            onboaradingDescLbl.text = "Berkontribusi dalam memberikan kemudahan bagi masyarakat untuk terlibat dalam tumbuh kembang anak."
            continueBtn.isHidden = true
        //            self.delegate?.carouselState(state: index)
        case 2:
            onboardingImage.image = UIImage(named: "slide_image_3")
            onboardingLbl.text = "WeKiddo bagi masa depan anak"
            onboaradingDescLbl.text = "Mari bangun masa depan anak ke arah yang lebih baik bersama WeKiddo."
        //            self.delegate?.carouselState(state: index)
        default:
            return
        }
    }
    @objc func toLoginPage() {
        self.delegate?.toLogin()
    }
}
