//
//  UIApplication.swift
//  Gadator
//
//  Created by Maciej Sączewski on 11/13/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
