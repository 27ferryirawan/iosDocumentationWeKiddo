//
//  ACTextfieldExtension.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 15/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    func shouldChangeCustomOtp(textField:UITextField, string: String) ->Bool {
        //Check if textField has two chacraters
        if ((textField.text?.count)! == 0  && string.count > 0) {
            let nextTag = textField.tag + 1;
            // get next responder
            var nextResponder = textField.superview?.viewWithTag(nextTag);
            if (nextResponder == nil) {
                nextResponder = textField.superview?.viewWithTag(1);
            }
            textField.text = textField.text! + string;
            //write here your last textfield tag
            if textField.tag == 6 {
                //Dissmiss keyboard on last entry
                textField.resignFirstResponder()
            } else {
                ///Appear keyboard
                nextResponder?.becomeFirstResponder();
            }
            return false;
        } else if ((textField.text?.count)! == 1  && string.count == 0) {// on deleteing value from Textfield
            let previousTag = textField.tag - 1;
            // get prev responder
            var previousResponder = textField.superview?.viewWithTag(previousTag);
            if (previousResponder == nil) {
                previousResponder = textField.superview?.viewWithTag(1);
            }
            textField.text = "";
            previousResponder?.becomeFirstResponder();
            return false
        }
        return true
    }
}

