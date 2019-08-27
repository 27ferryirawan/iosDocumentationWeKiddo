//
//  ACCustomNavigation.swift
//  AYO CLEAN
//
//  Created by zein rezky chandra on 30/06/18.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

extension UIViewController {
    func detectAdaptiveClass() {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2436: // iPhone X
                self.navigationController?.navigationBar.prefersLargeTitles = true
                let attributes = [
                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
                    NSAttributedString.Key.foregroundColor: UIColor.white
                ]
                UINavigationBar.appearance().titleTextAttributes = attributes
            case 2688: // iPhone XS Max
                self.navigationController?.navigationBar.prefersLargeTitles = true
                let attributes = [
                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
                    NSAttributedString.Key.foregroundColor: UIColor.white
                ]
                UINavigationBar.appearance().titleTextAttributes = attributes
            default:
                self.navigationController?.navigationBar.prefersLargeTitles = false
                let attributes = [
                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
                    NSAttributedString.Key.foregroundColor: UIColor.white
                ]
                UINavigationBar.appearance().titleTextAttributes = attributes
            }
        }
    }
    
    func validateTextfield(_ textFields: [UITextField]) -> Bool {
        for textField in textFields {
            if(textField.text?.isEmpty)!{
                ACAlert.show(message: textField.placeholder! + " are required")
                return false
            }
        }
        return true
    }
    
    func setStatusBarColor(){
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = ACColor.MAIN
        statusBarView.backgroundColor = statusBarColor
        self.view.addSubview(statusBarView)
    }
    
    func backStyleNavigationController(pageTitle:String, isLeftLogoHide:String, isLeftSecondLogoHide:String){
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = ACColor.MAIN
//        self.navigationController?.navigationBar.backgroundColor = ACColor.MAIN
//        self.navigationController?.navigationBar.tintColor = ACColor.MAIN
        self.navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        self.title = pageTitle
        self.navigationItem.title = pageTitle
//       self.tabBarItem.title = pageTitle
//        if pageTitle == "Notification" {
//            let backView = UIView(frame: CGRect(x: 0, y: 0, width: 88, height: 44))
//            let backLabel = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 88, height: 44)))
//            backLabel.text = pageTitle
//            backLabel.textColor = .white
//            backLabel.font = UIFont.boldSystemFont(ofSize: 16)
//            backView.addSubview(backLabel)
//            let backBarItem = UIBarButtonItem(customView: backView)
//            self.navigationItem.leftBarButtonItem = backBarItem
//            self.title = pageTitle
//        } else {
//
        if /*pageTitle == "Dashboard" || pageTitle == "Calendar" || pageTitle == "Score" || pageTitle == "More" || pageTitle == "Others"*/self == self.navigationController?.viewControllers[0] && pageTitle != "Add Student" {
            
            //Notification
            let notificationView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
            let notificationButton = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 44, height: 44)))
            notificationButton.setImage(UIImage(named: "ic_bell"), for: .normal)
            notificationButton.addTarget(self, action: #selector(goToNotification), for: .touchUpInside)
            notificationView.addSubview(notificationButton)
            let notificationBarButton = UIBarButtonItem(customView: notificationView)
            self.navigationItem.rightBarButtonItem = notificationBarButton
            
            //Wekiddo Logo
            let imageView = UIImageView(frame: CGRect(x: 0, y: -7, width: 55, height: 55))
            imageView.image = UIImage(named: isLeftLogoHide)
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 55))
            view.addSubview(imageView)
            let backBarItem = UIBarButtonItem(customView: view)
            self.navigationItem.leftBarButtonItem = backBarItem
        }
        else if pageTitle == "" {
            if isLeftLogoHide == "ic_back_blue" && isLeftSecondLogoHide == "" {
                self.navigationController?.navigationBar.barTintColor = .white
                let backButton = UIButton(type: .custom)
                backButton.frame = CGRect(x: 0, y: 0, width: 20, height: 44)
                backButton.addTarget(
                    self,
                    action: #selector(self.dismissSelf(_:)),
                    for: .touchUpInside
                )
                let backImageView = UIImageView(frame: CGRect(x: 0, y: 8, width: 35, height: 30))
                backImageView.image = UIImage(named: "ic_back_blue")
                
                let backView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 44))
                backView.addSubview(backImageView)
                backView.addSubview(backButton)
                
                let backBarItem = UIBarButtonItem(customView: backView)
                self.navigationItem.leftBarButtonItem = backBarItem
            }
        } else if pageTitle == "Add Student" {
            //Notification
            let notificationView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
            let notificationButton = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 33, height: 33)))
            notificationButton.setImage(UIImage(named: "ic_remove_gray"), for: .normal)
            notificationButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
            notificationView.addSubview(notificationButton)
            let notificationBarButton = UIBarButtonItem(customView: notificationView)
            self.navigationItem.rightBarButtonItem = notificationBarButton
        }
        else {
            if isLeftLogoHide == "" && isLeftSecondLogoHide == "" {
                // do nothing
            } else if isLeftLogoHide == "ic_arrow_left" && isLeftSecondLogoHide == "" {
                let backButton = UIButton(type: .custom)
                backButton.frame = CGRect(x: 0, y: 0, width: 20, height: 44)
                backButton.addTarget(
                    self,
                    action: #selector(self.dismissSelf(_:)),
                    for: .touchUpInside
                )
                let backImageView = UIImageView(frame: CGRect(x: 0, y: 8, width: 15, height: 25))
                backImageView.image = UIImage(named: "ic_arrow_left")

                let backView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 44))
                backView.addSubview(backImageView)
                backView.addSubview(backButton)

                let backBarItem = UIBarButtonItem(customView: backView)
                self.navigationItem.leftBarButtonItem = backBarItem
            } else if isLeftLogoHide == "ic_arrow_left" && isLeftSecondLogoHide != "" {
                let backButton = UIButton(type: .custom)
                backButton.frame = CGRect(x: 0, y: 0, width: 20, height: 44)
                backButton.addTarget(
                    self,
                    action: #selector(self.dismissSelf(_:)),
                    for: .touchUpInside
                )
                let backImageView = UIImageView(frame: CGRect(x: -5, y: 8, width: 15, height: 25))
                backImageView.image = UIImage(named: "ic_arrow_left")
                let secondImageView = UIImageView(frame: CGRect(x: 18, y: -7, width: 55, height: 55))
                secondImageView.image = UIImage(named: isLeftSecondLogoHide)

                let backView = UIView(frame: CGRect(x: 0, y: 0, width: 65, height: 55))
                backView.addSubview(backImageView)
                backView.addSubview(backButton)
                backView.addSubview(secondImageView)
                
                let backBarItem = UIBarButtonItem(customView: backView)
                self.navigationItem.leftBarButtonItem = backBarItem
            } else if isLeftLogoHide != "" && isLeftSecondLogoHide == ""{
                let imageView = UIImageView(frame: CGRect(x: 0, y: -7, width: 55, height: 55))
                imageView.image = UIImage(named: isLeftLogoHide)
                
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 55))
                view.addSubview(imageView)
                
                let backBarItem = UIBarButtonItem(customView: view)
                self.navigationItem.leftBarButtonItem = backBarItem
            } else if isLeftLogoHide != "" && isLeftSecondLogoHide != ""{
                let imageView = UIImageView(frame: CGRect(x: -15, y: -7, width: 55, height: 55))
                imageView.image = UIImage(named: isLeftLogoHide)
                let secondImageView = UIImageView(frame: CGRect(x: 35, y: -7, width: 55, height: 55))
                secondImageView.image = UIImage(named: isLeftSecondLogoHide)
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 55))
                view.addSubview(imageView)
                view.addSubview(secondImageView)
                let backBarItem = UIBarButtonItem(customView: view)
                self.navigationItem.leftBarButtonItem = backBarItem
            }
        }
    }
    
    @objc func goToNotification() {
        let notificationVC = NotificationViewController()
        self.navigationController?.pushViewController(notificationVC, animated: true)
    }
    
    @objc func closeVC() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissSelf(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension NSObject {
    func validateString(_ values: [String]) -> Bool{
        for value in values {
            if(value.isEmpty){
                return false
            }
        }
        return true
    }
}
