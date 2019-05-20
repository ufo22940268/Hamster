//
//  Extensions.swift
//  Hamster
//
//  Created by Frank Cheng on 2019/5/16.
//  Copyright © 2019 Frank Cheng. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func useAutolayout() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}

extension String {
    func isURL() -> Bool {
        let urlRegEx = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
        let result = urlTest.evaluate(with: selff)
        return result
//        let url = URL(string: self)
//        if let url = url, dlet _ = url.host {
//            return true
//        } else {
//            return false
//        }
    }
}
