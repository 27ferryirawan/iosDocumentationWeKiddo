//
//  NewsDetailViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 03/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import WebKit

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var webContent: WKWebView!
    var stringURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configWeb()
    }
    
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "News Detail", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        }
        else{
            backStyleNavigationController(pageTitle: "News Detail", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configWeb() {
        webContent.scrollView.showsVerticalScrollIndicator = false
        webContent.scrollView.delegate = self
        webContent.load(URLRequest(url: URL(string: stringURL)!))
//        webView.loadHTMLString("<body style='color: #000 !important;font-family:TimesNewRoman-Regular;font-size:20px;line-height:46px;'>\(stringURL)<body>", baseURL: nil)
    }
}

extension NewsDetailViewController: UIScrollViewDelegate {
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.pinchGestureRecognizer?.isEnabled = false
    }
}
