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
    @discardableResult
    func useAutolayout() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func sameSizeAsParent() {
        guard let superview = superview else { fatalError() }
        self.useAutolayout()
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            topAnchor.constraint(equalTo: superview.topAnchor),
            widthAnchor.constraint(equalTo: superview.widthAnchor),
            heightAnchor.constraint(equalTo: superview.heightAnchor)])
    }
}

extension String {
    func isURL() -> Bool {
        let urlRegEx = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
        let result = urlTest.evaluate(with: self)
        return result
    }
}

extension UIViewController {
    func isInitial() -> Bool {
//        guard UIDevice.isSimulator else { fatalError() }
        let initialVC =  storyboard!.instantiateInitialViewController()!
        if let navigationVC = initialVC as? UINavigationController {
            return type(of: navigationVC.topViewController!) == type(of: self)
        } else {
            return type(of: initialVC) == type(of: self)
        }
    }
}

extension UIDevice {
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}


