//
//  View+Extension.swift
//  NYCSchools
//
//  Created by Sara on 16/12/22.
//

import Foundation
import UIKit
public extension UIView {
    func addShadow() {
        self.layer.shadowColor  = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5.0
        self.layer.masksToBounds = false
    }
}
