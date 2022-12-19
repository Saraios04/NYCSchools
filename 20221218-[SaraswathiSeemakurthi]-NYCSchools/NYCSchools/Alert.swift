//
//  Alert.swift
//  NYCSchools
//
//  Created by Sara on 18/12/22.
//

import Foundation
import UIKit
open class Alert: NSObject {
    
    public class func displayAlert(title: String, message: String, view: UIViewController, completion: @escaping () -> () = {}) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
            _ in
            completion()
        }))
        let subview = (alert.view.subviews.first?.subviews.first?.subviews.first)! as UIView
        subview.backgroundColor = UIColor.white
        alert.view.tintColor = UIColor.black
        
        let attributedString = NSAttributedString(string:  title, attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18.0),
            NSAttributedString.Key.foregroundColor : UIColor.black
        ])
        let messageString = NSAttributedString(string:  message, attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14.0),
            NSAttributedString.Key.foregroundColor : UIColor.black
        ])
        alert.setValue(messageString, forKey: "attributedMessage")
        alert.setValue(attributedString, forKey: "attributedTitle")
        DispatchQueue.main.async {
            view.present(alert, animated: true, completion: nil)
        }
    }


}
