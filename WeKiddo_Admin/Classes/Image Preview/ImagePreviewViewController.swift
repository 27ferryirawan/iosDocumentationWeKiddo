//
//  ImagePreviewViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 12/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import AVKit

class ImagePreviewViewController: UIViewController {

    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var imageContent: UIImageView!
    var imageURL = ""
    var isPreviewImage = false
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonClose.addTarget(self, action: #selector(dismis), for: .touchUpInside)
        if isPreviewImage {
            imageContent.sd_setImage(
                with: URL(string: imageURL),
                placeholderImage: UIImage(named: "WeKiddoLogo"),
                options: .refreshCached
            )
        } else {
            if let url = URL(string: imageURL) {
                let player = AVPlayer(url: url)
                let controller = AVPlayerViewController()
                controller.player = player
                controller.view.frame = self.view.frame
                self.view.addSubview(controller.view)
                self.addChild(controller)
                player.play()
            }
        }
        configNavigation()
    }
    
    func configNavigation(){
        self.navigationController?.isNavigationBarHidden = false
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Image", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Image", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    @objc func dismis() {
        self.dismiss(animated: true, completion: nil)
    }
}
