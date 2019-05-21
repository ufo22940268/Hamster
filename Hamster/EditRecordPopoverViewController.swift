//
//  EditRecordPopoverViewController.swift
//  Hamster
//
//  Created by Frank Cheng on 2019/5/21.
//  Copyright © 2019 Frank Cheng. All rights reserved.
//

import Foundation
import UIKit

class EditRecordPopoverViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .popover
        preferredContentSize = CGSize(width: 100, height: 70)
        popoverPresentationController?.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EditRecordPopoverViewController: UIPopoverPresentationControllerDelegate {

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
