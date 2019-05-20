//
//  AddRecordFields.swift
//  Hamster
//
//  Created by Frank Cheng on 2019/5/20.
//  Copyright © 2019 Frank Cheng. All rights reserved.
//

import Foundation
import UIKit

protocol Validator {
    func validate() -> Bool
}

class URLAddField: UITextField, Validator {
    func validate() -> Bool {
        return (text ?? "").isURL()
    }
}


class NormalAddField: UITextField, Validator {
    func validate() -> Bool {
        return (text ?? "").count > 0
    }
}
